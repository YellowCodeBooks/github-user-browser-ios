import SwiftUI
import Combine

struct DetailView: View {
    let username: String
        @StateObject private var viewModel: DetailViewModel

        init(username: String, viewModel: DetailViewModel? = nil) {
            self.username = username
            _viewModel = StateObject(wrappedValue: viewModel ?? {
                let api = GitHubApiServiceImpl()
                let repo = UserRepositoryImpl(apiService: api)
                let useCase = GetUserDetailUseCase(repository: repo)
                return DetailViewModel(getUserDetailUseCase: useCase)
            }())
        }

        var body: some View {
            Group {
                if let user = viewModel.userDetail {
                    ScrollView {
                        VStack(spacing: 16) {
                            AsyncImage(url: URL(string: user.avatarUrl)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray.opacity(0.3)
                            }
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())

                            Text(user.login)
                                .font(.title)
                                .bold()

                            if let location = user.location {
                                HStack {
                                    Image(systemName: "location")
                                    Text(location)
                                }
                                .foregroundColor(.gray)
                            }

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
