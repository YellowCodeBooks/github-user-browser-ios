struct GitHubUserDto: Codable {
    let id: Int
    let login: String
    let avatar_url: String
    let html_url: String
}

extension GitHubUserDto {
    func toDomain() -> GitHubUser {
        GitHubUser(id: id, login: login, avatar_url: avatar_url, html_url: html_url)
    }
}
