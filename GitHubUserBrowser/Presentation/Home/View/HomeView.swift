import SwiftUI

struct HomeView: View {
    let users: [GitHubUser]
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink(destination: DetailView(username: user.login)) {
                    UserCard(
                        avatarUrl: user.avatar_url,
                        title: user.login,
                        subtitle: user.html_url
                    )
                }
            }
        }
        .navigationTitle("GitHub Users")
    }
}

#Preview {
    HomeView(users: [
        GitHubUser(
            id: 1,
            login: "mojombo",
            avatar_url: "https://avatars.githubusercontent.com/u/1?v=4",
            html_url: "https://github.com/mojombo"
        ),
        GitHubUser(
            id: 2,
            login: "defunkt",
            avatar_url: "https://avatars.githubusercontent.com/u/2?v=4",
            html_url: "https://github.com/defunkt"
        )
    ])
}
