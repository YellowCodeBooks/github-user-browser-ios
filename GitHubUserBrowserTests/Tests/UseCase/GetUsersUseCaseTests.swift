import XCTest
import Combine
@testable import GitHubUserBrowser

final class GetUsersUseCaseTests: XCTestCase {
    
    class MockUserRepository: UserRepository {
        func getUsers(since: Int, perPage: Int) -> AnyPublisher<[User], Error> {
            let users = [
                User(id: 1, login: "user1", avatar_url: "url1", html_url: "html1"),
                User(id: 2, login: "user2", avatar_url: "url2", html_url: "html2")
            ]
            return Just(users)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        func getUserDetail(username: String) -> AnyPublisher<UserDetail, Error> {
            fatalError("Not needed for this test")
        }
    }
    
    func testGetUsersUseCaseReturnsUsers() {
        let repository = MockUserRepository()
        let useCase = GetUsersUseCase(repository: repository)
        
        let expectation = XCTestExpectation(description: "Should return 2 users")
        var receivedUsers: [User] = []
        
        let cancellable = useCase.execute(since: 0)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { users in
                receivedUsers = users
                expectation.fulfill()
            })
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedUsers.count, 2)
        cancellable.cancel()
    }
}
