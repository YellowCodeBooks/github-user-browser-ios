import SwiftUI

struct UserCard: View {
    let avatarUrl: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: avatarUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 70, height: 70)
            .clipShape(Circle())
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 78, height: 78)
            )
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                
                Divider()
                
                HStack(spacing: 4) {
                    if subtitle.starts(with: "http") {
                        Text(subtitle)
                            .foregroundColor(.blue)
                            .underline()
                            .lineLimit(1)
                            .font(.subheadline)
                    } else {
                        Image("icon_location")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.gray)
                        Text(subtitle)
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                }
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    UserCard(
        avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4",
        title: "mojombo",
        subtitle: "https://github.com/mojombo"
    )
    .padding()
}
