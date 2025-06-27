import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let getUsersUseCase: GetUsersUseCase
    private var cancellables = Set<AnyCancellable>()
    private var since: Int = 0
    private var reachedEnd: Bool = false
    
    init(getUsersUseCase: GetUsersUseCase) {
        self.getUsersUseCase = getUsersUseCase
    }
    
    func loadUsers() {
        guard !isLoading, !reachedEnd else { return }
        
        isLoading = true
        errorMessage = nil
        
        getUsersUseCase.execute(since: since)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] newUsers in
                if newUsers.isEmpty {
                    self?.reachedEnd = true
                } else {
                    self?.since += newUsers.count
                    self?.users.append(contentsOf: newUsers)
                }
            }
            .store(in: &cancellables)
    }
}
