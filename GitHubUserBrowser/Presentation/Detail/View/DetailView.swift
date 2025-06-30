import SwiftUI
import SwiftData
import Combine

struct DetailView: View {
    let username: String
    @StateObject var viewModel: DetailViewModel
    
    var body: some View {
        Group {
            if let user = viewModel.userDetail {
                ScrollView {
                    VStack(spacing: 16) {
                        UserCard(
                            avatarUrl: user.avatarUrl,
                            title: user.login,
                            subtitle: user.location ?? "Unknown"
                        )
                        .padding(.bottom, 18)
                        
                        HStack(spacing: 24) {
                            FollowerStat(title: "Follower", count: user.followers)
                            FollowerStat(title: "Following", count: user.following)
                        }
                        
                        if let blog = user.blog, !blog.isEmpty {
                            Link(blog, destination: URL(string: blog)!)
                                .foregroundColor(.blue)
                                .underline()
                        }
                    }
                    .padding()
                }
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)").foregroundColor(.red).padding()
            } else {
                ProgressView("Loading...")
                    .onAppear {
                        viewModel.loadUserDetail(username: username)
                    }
            }
        }
        .navigationTitle("Detail")
    }
}

#Preview {
    let mockUsers = [
        User(id: 1, login: "mojombo", avatar_url: "https://avatars.githubusercontent.com/u/1?v=4", html_url: "https://github.com/mojombo"),
        User(id: 2, login: "defunkt", avatar_url: "https://avatars.githubusercontent.com/u/2?v=4", html_url: "https://github.com/defunkt")
    ]
    let mockRepository = MockUserRepository(users: mockUsers)
    let useCase = GetUserDetailUseCase(repository: mockRepository)
    let viewModel = DetailViewModel(getUserDetailUseCase: useCase)

    NavigationView {
        DetailView(username: "mojombo", viewModel: viewModel)
    }
}
