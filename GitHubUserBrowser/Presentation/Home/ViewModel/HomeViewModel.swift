import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var users: [GitHubUser] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let getUsersUseCase: GetUsersUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(getUsersUseCase: GetUsersUseCase) {
        self.getUsersUseCase = getUsersUseCase
        loadUsers()
    }
    
    func loadUsers() {
        isLoading = true
        errorMessage = nil
        
        getUsersUseCase.execute(since: 0)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] users in
                self?.users = users
            })
            .store(in: &cancellables)
    }
}
