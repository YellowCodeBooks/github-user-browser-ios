//
//  GitHubUserBrowserApp.swift
//  GitHubUserBrowser
//
//  Created by Yellow Code on 26/6/25.
//

import SwiftUI

@main
struct GitHubUserBrowserApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
