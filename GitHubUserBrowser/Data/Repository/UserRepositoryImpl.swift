import Combine

class UserRepositoryImpl: UserRepository {
    private let apiService: GitHubApiService
    
    init(apiService: GitHubApiService) {
        self.apiService = apiService
    }
    
    func getUsers(since: Int, perPage: Int) -> AnyPublisher<[GitHubUser], Error> {
        apiService.getUsers(since: since, perPage: perPage)
            .map { $0.map { $0.toDomain() } }
            .eraseToAnyPublisher()
    }
    
    func getUserDetail(username: String) -> AnyPublisher<GitHubUserDetail, Error> {
        apiService.getUserDetail(username: username)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
