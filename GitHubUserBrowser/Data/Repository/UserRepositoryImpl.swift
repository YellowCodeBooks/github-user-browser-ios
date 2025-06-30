import Combine
import SwiftData
import SwiftUI

class UserRepositoryImpl: UserRepository {
    private let apiService: GitHubApiService
    private let context: ModelContext
    
    init(apiService: GitHubApiService, context: ModelContext) {
        self.apiService = apiService
        self.context = context
    }
    
    func getUsers(since: Int, perPage: Int) -> AnyPublisher<[User], Error> {
        return apiService.getUsers(since: since, perPage: perPage)
            .handleEvents(receiveOutput: { [weak self] dtos in
                guard let self = self else { return }
                let users = dtos.map { $0.toDomain() }
                
                for user in users {
//                    self.context.insert(user.toCachedModel())
                }
                
                try? self.context.save()
            })
            .map { $0.map { $0.toDomain() } }
            .catch { [weak self] error -> AnyPublisher<[User], Error> in
                guard let self = self else {
                    return Fail(error: error).eraseToAnyPublisher()
                }
                
                let descriptor = FetchDescriptor<CachedUser>(sortBy: [.init(\.id)])
                let cachedUsers = (try? self.context.fetch(descriptor)) ?? []
                let mapped = cachedUsers.map { User(cached: $0) }
                
                return Just(mapped)
                    .setFailureType(to: Error.self)
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
