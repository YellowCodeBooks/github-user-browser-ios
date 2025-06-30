import Combine
import SwiftData
import SwiftUI

class UserRepositoryImpl: UserRepository {
    private let apiService: GitHubApiService
    private let dataActor: DataActor
    
    init(apiService: GitHubApiService, dataActor: DataActor) {
        self.apiService = apiService
        self.dataActor = dataActor
    }
    
    func getUsers(since: Int, perPage: Int) -> AnyPublisher<[User], Error> {
        return apiService.getUsers(since: since, perPage: perPage)
            .handleEvents(receiveOutput: { [weak self] dtos in
                guard let self = self else { return }
                let users = dtos.map { $0.toDomain() }
                
                Task {
                    for user in users {
                        await self.dataActor.save(user: user.toCachedModel())
                    }
                }
            })
            .map { $0.map { $0.toDomain() } }
            .catch { [weak self] error -> AnyPublisher<[User], Error> in
                guard let self = self else {
                    return Fail(error: error).eraseToAnyPublisher()
                }
                
                return Future<[User], Error> { promise in
                    Task {
                        let cachedUsers = await self.dataActor.fetchUsers()
                        let mapped = cachedUsers.map { User(cached: $0) }
                        promise(.success(mapped))
                    }
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    
    func getUserDetail(username: String) -> AnyPublisher<UserDetail, Error> {
        apiService.getUserDetail(username: username)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
