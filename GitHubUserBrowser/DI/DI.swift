import SwiftData

@MainActor
enum DI {
    static func homeViewModel() -> HomeViewModel {
        let api = GitHubApiServiceImpl()
        let context = try! ModelContainer(for: CachedUser.self).mainContext
        let repository = UserRepositoryImpl(apiService: api, context: context)
        let useCase = GetUsersUseCase(repository: repository)
        return HomeViewModel(getUsersUseCase: useCase)
    }
    
    static func detailViewModel(username: String) -> DetailViewModel {
        let api = GitHubApiServiceImpl()
        let context = try! ModelContainer(for: CachedUser.self).mainContext
        let repo = UserRepositoryImpl(apiService: api, context: context)
        let useCase = GetUserDetailUseCase(repository: repo)
        let vm = DetailViewModel(getUserDetailUseCase: useCase)
        vm.loadUserDetail(username: username)
        return vm
    }
}
