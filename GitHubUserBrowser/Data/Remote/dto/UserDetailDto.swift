struct UserDetailDto: Decodable {
    let login: String
    let avatar_url: String
    let location: String?
    let blog: String?
    let followers: Int
    let following: Int
}
