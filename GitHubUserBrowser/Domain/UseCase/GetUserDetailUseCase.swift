import Combine

struct GetUserDetailUseCase {
    let repository: UserRepository

    func execute(username: String) -> AnyPublisher<UserDetail, Error> {
        repository.getUserDetail(username: username)
    }
}
