import Combine

protocol UserRepository {
    func getUsers(since: Int, perPage: Int) -> AnyPublisher<[User], Error>
    func getUserDetail(username: String) -> AnyPublisher<UserDetail, Error>
}
