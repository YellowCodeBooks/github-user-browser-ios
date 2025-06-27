struct GitHubUserDetailDto: Decodable {
    let login: String
    let avatar_url: String
    let location: String?
    let blog: String?
    let followers: Int
    let following: Int
}

extension GitHubUserDetailDto {
    func toDomain() -> GitHubUserDetail {
        GitHubUserDetail(
            login: login,
            avatarUrl: avatar_url,
            location: location,
            blog: blog,
            followers: followers,
            following: following
        )
    }
}
