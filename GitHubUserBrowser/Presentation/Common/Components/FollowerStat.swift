import SwiftUI

struct FollowerStat: View {
    let title: String
        let count: Int

        var body: some View {
            VStack {
                Text("\(count)")
                    .font(.headline)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(8)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        }
}

#Preview(traits: .sizeThatFitsLayout) {
    FollowerStat(title: "Follower", count: 1234)
        .padding()
}
