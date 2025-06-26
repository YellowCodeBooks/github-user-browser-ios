//
//  UserCard.swift
//  GitHubUserBrowser
//
//  Created by Yellow Code on 26/6/25.
//

import SwiftUI

struct UserCard: View {
    let avatarUrl: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: avatarUrl)) { image in
                image.resizable()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 48, height: 48)
            .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .underline()
                    .lineLimit(1)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    UserCard(
        avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4",
        title: "mojombo",
        subtitle: "https://github.com/mojombo"
    )
    .padding()
    .previewLayout(.sizeThatFits)
}
