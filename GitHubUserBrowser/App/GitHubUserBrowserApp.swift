import SwiftUI

@main
struct GitHubUserBrowserApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: DI.homeViewModel())
        }
    }
}
