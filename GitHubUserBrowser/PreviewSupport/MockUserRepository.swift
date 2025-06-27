import Combine
import Foundation

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
    
    func getUserDetail(username: String) -> AnyPublisher<GitHubUserDetail, Error> {
        let mockUserDetail = GitHubUserDetail(
            login: "mojombo",
            avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4",
            location: "San Francisco",
            blog: "https://tom.preston-werner.com",
            followers: 1200,
            following: 150
        )
        return Just(mockUserDetail)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
