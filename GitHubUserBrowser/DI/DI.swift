import SwiftData

@MainActor
enum DI {
    static func homeViewModel() -> HomeViewModel {
        let api = GitHubApiServiceImpl()
        let dataActor = DataActor.shared
        let repository = UserRepositoryImpl(apiService: api, dataActor: dataActor)
        let useCase = GetUsersUseCase(repository: repository)
        return HomeViewModel(getUsersUseCase: useCase)
    }
    
    static func detailViewModel(username: String) -> DetailViewModel {
        let api = GitHubApiServiceImpl()
        let dataActor = DataActor.shared
        let repo = UserRepositoryImpl(apiService: api, dataActor: dataActor)
        let useCase = GetUserDetailUseCase(repository: repo)
        let vm = DetailViewModel(getUserDetailUseCase: useCase)
        vm.loadUserDetail(username: username)
        return vm
    }
}
