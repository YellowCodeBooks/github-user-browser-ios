import Combine

struct GetUserDetailUseCase {
    let repository: UserRepository

    func execute(username: String) -> AnyPublisher<GitHubUserDetail, Error> {
        repository.getUserDetail(username: username)
    }
}
