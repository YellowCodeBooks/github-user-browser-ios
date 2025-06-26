//
//  DetailView.swift
//  GitHubUserBrowser
//
//  Created by Yellow Code on 26/6/25.
//

import SwiftUI

struct DetailView: View {
    let username: String
    
    var body: some View {
        VStack(spacing: 16) {
            Text("User Detail for:")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(username)
                .font(.largeTitle)
                .bold()
        }
        .padding()
        .navigationTitle("Detail")
    }
}

#Preview {
    NavigationView {
        DetailView(username: "mojombo")
    }
}
