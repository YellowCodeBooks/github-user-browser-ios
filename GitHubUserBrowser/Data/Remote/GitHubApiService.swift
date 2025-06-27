import Combine
import Foundation

protocol GitHubApiService {
    func getUsers(since: Int, perPage: Int) -> AnyPublisher<[GitHubUserDto], Error>
}

class GitHubApiServiceImpl: GitHubApiService {
    func getUsers(since: Int, perPage: Int) -> AnyPublisher<[GitHubUserDto], Error> {
        let urlString = "https://api.github.com/users?since=\(since)&per_page=\(perPage)"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [GitHubUserDto].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
