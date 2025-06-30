import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.users.indices, id: \.self) { index in
                        let user = viewModel.users[index]
                        
                        NavigationLink(destination: DetailView(
                            username: user.login,
                            viewModel: DI.detailViewModel(username: user.login)
                        )) {
                            UserCard(
                                avatarUrl: user.avatar_url,
                                title: user.login,
                                subtitle: user.html_url
                            )
                            .onAppear {
                                if index == viewModel.users.count - 5 {
                                    viewModel.loadUsers()
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .padding(.top, 16)
                    }
                    
                    if let error = viewModel.errorMessage {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.top, 16)
                    }
                }
                .padding()
            }
            .navigationTitle("GitHub Users")
            .onAppear {
                if viewModel.users.isEmpty {
                    viewModel.loadUsers()
                }
            }
        }
    }
}

#Preview {
    let mockUsers = [
        User(id: 1, login: "mojombo", avatar_url: "https://avatars.githubusercontent.com/u/1?v=4", html_url: "https://github.com/mojombo"),
        User(id: 2, login: "defunkt", avatar_url: "https://avatars.githubusercontent.com/u/2?v=4", html_url: "https://github.com/defunkt")
    ]
    
    let mockRepository = MockUserRepository(users: mockUsers)
    let useCase = GetUsersUseCase(repository: mockRepository)
    let viewModel = HomeViewModel(getUsersUseCase: useCase)
    
    return HomeView(viewModel: viewModel)
}
