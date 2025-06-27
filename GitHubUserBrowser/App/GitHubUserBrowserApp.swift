import SwiftUI

@main
struct GitHubUserBrowserApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            // Setup dependencies
            let apiService = GitHubApiServiceImpl()
            let repository = UserRepositoryImpl(apiService: apiService)
            let useCase = GetUsersUseCase(repository: repository)
            let viewModel = HomeViewModel(getUsersUseCase: useCase)
            
            HomeView(viewModel: viewModel)
        }
    }
}
