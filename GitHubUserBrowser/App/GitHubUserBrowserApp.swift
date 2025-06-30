import SwiftUI
import SwiftData

@main
struct GitHubUserBrowserApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: DI.homeViewModel())
        }
        .modelContainer(for: CachedUser.self)
    }
}
