struct GitHubUser: Identifiable, Codable {
    let id: Int
    let login: String
    let avatar_url: String
    let html_url: String
}
