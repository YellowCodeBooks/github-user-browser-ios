import Foundation
import SwiftData

@Model
class CachedUser {
    var id: Int
    var login: String
    var avatar_url: String
    var html_url: String

    init(id: Int, login: String, avatar_url: String, html_url: String) {
        self.id = id
        self.login = login
        self.avatar_url = avatar_url
        self.html_url = html_url
    }
}
