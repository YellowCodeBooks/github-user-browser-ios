import XCTest
import Combine
@testable import GitHubUserBrowser

final class DetailViewModelTests: XCTestCase {
    
    class MockUserRepository: UserRepository {
        private let result: Result<UserDetail, Error>

        init(result: Result<UserDetail, Error>) {
            self.result = result
        }

        func getUsers(since: Int, perPage: Int) -> AnyPublisher<[User], Error> {
            fatalError("Not needed")
        }

        func getUserDetail(username: String) -> AnyPublisher<UserDetail, Error> {
            return result.publisher.eraseToAnyPublisher()
        }
    }
    
    var cancellables = Set<AnyCancellable>()

    func testLoadUserDetail_success() {
        // Given
        let expectedDetail = UserDetail(
            login: "mojombo",
            avatarUrl: "https://example.com/avatar.jpg",
            location: "California",
            blog: "https://blog.example.com",
            followers: 10,
            following: 5
        )

        let repo = MockUserRepository(result: .success(expectedDetail))
        let useCase = GetUserDetailUseCase(repository: repo)
        let viewModel = DetailViewModel(getUserDetailUseCase: useCase)

        let expectation = expectation(description: "Load user detail")

        // When
        viewModel.loadUserDetail(username: "mojombo")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            // Then
            XCTAssertNotNil(viewModel.userDetail)
            XCTAssertEqual(viewModel.userDetail?.login, "mojombo")
            XCTAssertNil(viewModel.errorMessage)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testLoadUserDetail_failure() {
        // Given
        let repo = MockUserRepository(result: .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Network error"])))
        let useCase = GetUserDetailUseCase(repository: repo)
        let viewModel = DetailViewModel(getUserDetailUseCase: useCase)

        let expectation = expectation(description: "Fail loading user detail")

        // When
        viewModel.loadUserDetail(username: "unknown")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            // Then
            XCTAssertNil(viewModel.userDetail)
            XCTAssertEqual(viewModel.errorMessage, "Network error")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}
