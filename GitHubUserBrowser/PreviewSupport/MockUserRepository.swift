import Combine

class MockUserRepository: UserRepository {
    let users: [GitHubUser]

    init(users: [GitHubUser]) {
        self.users = users
    }

    func getUsers(since: Int, perPage: Int) -> AnyPublisher<[GitHubUser], Error> {
        Just(users)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
