import XCTest
import Combine
@testable import GitHubUserBrowser

final class GetUserDetailUseCaseTests: XCTestCase {
    
    class MockUserRepository: UserRepository {
        func getUsers(since: Int, perPage: Int) -> AnyPublisher<[User], Error> {
            fatalError("Not needed for this test")
        }
        
        func getUserDetail(username: String) -> AnyPublisher<UserDetail, Error> {
            let detail = UserDetail(
                login: username,
                avatarUrl: "https://example.com/avatar.png",
                location: "Hanoi",
                blog: "https://myblog.dev",
                followers: 123,
                following: 45
            )
            return Just(detail)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    func testGetUserDetailReturnsCorrectUser() {
        let repository = MockUserRepository()
        let useCase = GetUserDetailUseCase(repository: repository)
        let username = "mockuser"
        
        let expectation = XCTestExpectation(description: "Should return user detail for \(username)")
        var receivedDetail: UserDetail?
        
        let cancellable = useCase.execute(username: username)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { detail in
                receivedDetail = detail
                expectation.fulfill()
            })
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedDetail?.login, username)
        XCTAssertEqual(receivedDetail?.followers, 123)
        XCTAssertEqual(receivedDetail?.following, 45)
        
        cancellable.cancel()
    }
}
