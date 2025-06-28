enum DI {
    static func homeViewModel() -> HomeViewModel {
        let api = GitHubApiServiceImpl()
        let repository = UserRepositoryImpl(apiService: api)
        let useCase = GetUsersUseCase(repository: repository)
        return HomeViewModel(getUsersUseCase: useCase)
    }
}
