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
    }
}
