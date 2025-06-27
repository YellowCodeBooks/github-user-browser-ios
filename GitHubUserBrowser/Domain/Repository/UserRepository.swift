import Combine

protocol UserRepository {
    func getUsers(since: Int, perPage: Int) -> AnyPublisher<[GitHubUser], Error>
}
