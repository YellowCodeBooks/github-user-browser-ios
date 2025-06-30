import Combine

class DetailViewModel: ObservableObject {
    @Published var userDetail: UserDetail?
    @Published var errorMessage: String?
    
    private let getUserDetailUseCase: GetUserDetailUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(getUserDetailUseCase: GetUserDetailUseCase) {
        self.getUserDetailUseCase = getUserDetailUseCase
    }
    
    func loadUserDetail(username: String) {
        getUserDetailUseCase.execute(username: username)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { detail in
                self.userDetail = detail
            }
            .store(in: &cancellables)
    }
}
