import Combine
import Foundation

protocol GitHubApiService {
    func getUsers(since: Int, perPage: Int) -> AnyPublisher<[UserDto], Error>
    func getUserDetail(username: String) -> AnyPublisher<UserDetailDto, Error>
}

class GitHubApiServiceImpl: GitHubApiService {
    func getUsers(since: Int, perPage: Int) -> AnyPublisher<[UserDto], Error> {
        let urlString = "https://api.github.com/users?since=\(since)&per_page=\(perPage)"
        print("NhutLog - API Request: GET \(urlString) - since: \(since), perPage: \(perPage)")
        
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [UserDto].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getUserDetail(username: String) -> AnyPublisher<UserDetailDto, Error> {
        let urlString = "https://api.github.com/users/\(username)"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: UserDetailDto.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
