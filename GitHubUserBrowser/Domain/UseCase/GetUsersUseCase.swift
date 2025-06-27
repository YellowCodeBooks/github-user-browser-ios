import Combine

class GetUsersUseCase {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute(since: Int, perPage: Int = 20) -> AnyPublisher<[User], Error> {
        repository.getUsers(since: since, perPage: perPage)
    }
}
