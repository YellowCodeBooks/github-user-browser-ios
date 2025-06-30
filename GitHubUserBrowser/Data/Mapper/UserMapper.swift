extension UserDto {
    func toDomain() -> User {
        User(id: id, login: login, avatar_url: avatar_url, html_url: html_url)
    }
}

extension UserDetailDto {
    func toDomain() -> UserDetail {
        UserDetail(
            login: login,
            avatarUrl: avatar_url,
            location: location,
            blog: blog,
            followers: followers,
            following: following
        )
    }
}

extension User {
    init(cached: CachedUser) {
        self.init(
            id: cached.id,
            login: cached.login,
            avatar_url: cached.avatar_url,
            html_url: cached.html_url
        )
    }

    func toCachedModel() -> CachedUser {
        return CachedUser(
            id: self.id,
            login: self.login,
            avatar_url: self.avatar_url,
            html_url: self.html_url
        )
    }
}
