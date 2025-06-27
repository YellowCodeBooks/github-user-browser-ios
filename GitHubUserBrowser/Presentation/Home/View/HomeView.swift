import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.users) { user in
                NavigationLink(destination: DetailView(username: user.login)) {
                    UserCard(
                        avatarUrl: user.avatar_url,
                        title: user.login,
                        subtitle: user.html_url
                    )
                }
            }
            .navigationTitle("GitHub Users")
        }
    }
}

#Preview {
    let mockUsers = [
        GitHubUser(id: 1, login: "mojombo", avatar_url: "https://avatars.githubusercontent.com/u/1?v=4", html_url: "https://github.com/mojombo"),
        GitHubUser(id: 2, login: "defunkt", avatar_url: "https://avatars.githubusercontent.com/u/2?v=4", html_url: "https://github.com/defunkt")
    ]
    
    let mockRepository = MockUserRepository(users: mockUsers)
    let useCase = GetUsersUseCase(repository: mockRepository)
    let viewModel = HomeViewModel(getUsersUseCase: useCase)
    
    return HomeView(viewModel: viewModel)
}
