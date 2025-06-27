import SwiftUI

@main
struct GitHubUserBrowserApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            let mockUsers = [
                GitHubUser(id: 1, login: "mojombo", avatar_url: "https://avatars.githubusercontent.com/u/1?v=4", html_url: "https://github.com/mojombo"),
                GitHubUser(id: 2, login: "defunkt", avatar_url: "https://avatars.githubusercontent.com/u/2?v=4", html_url: "https://github.com/defunkt")
            ]
            
            let repository = MockUserRepository(users: mockUsers)
            let useCase = GetUsersUseCase(repository: repository)
            let viewModel = HomeViewModel(getUsersUseCase: useCase)
            
            HomeView(viewModel: viewModel)
        }
    }
}
