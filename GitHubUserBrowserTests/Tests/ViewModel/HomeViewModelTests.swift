import XCTest
import Combine
@testable import GitHubUserBrowser

final class HomeViewModelTests: XCTestCase {
    
    class MockUserRepository: UserRepository {
        private let result: Result<[User], Error>
        
        init(result: Result<[User], Error>) {
            self.result = result
        }
        
        func getUsers(since: Int, perPage: Int) -> AnyPublisher<[User], Error> {
            return result.publisher.eraseToAnyPublisher()
        }
        
        func getUserDetail(username: String) -> AnyPublisher<UserDetail, Error> {
            fatalError("Not used in this test")
        }
    }
    
    var cancellables = Set<AnyCancellable>()
    
    func testLoadUsers_success() {
        // Given
        let mockUsers = [
            User(id: 1, login: "user1", avatar_url: "url1", html_url: "profile1"),
            User(id: 2, login: "user2", avatar_url: "url2", html_url: "profile2")
        ]
        let repository = MockUserRepository(result: .success(mockUsers))
        let useCase = GetUsersUseCase(repository: repository)
        let viewModel = HomeViewModel(getUsersUseCase: useCase)
        
        let expectation = expectation(description: "Load users")
        
        // When
        viewModel.loadUsers()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            // Then
            XCTAssertEqual(viewModel.users.count, 2)
            XCTAssertEqual(viewModel.users.first?.login, "user1")
            XCTAssertNil(viewModel.errorMessage)
            XCTAssertFalse(viewModel.isLoading)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadUsers_failure() {
        // Given
        let repository = MockUserRepository(result: .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Fake failure"])))
        let useCase = GetUsersUseCase(repository: repository)
        let viewModel = HomeViewModel(getUsersUseCase: useCase)
        
        let expectation = expectation(description: "Load users failed")
        
        // When
        viewModel.loadUsers()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            // Then
            XCTAssertTrue(viewModel.users.isEmpty)
            XCTAssertEqual(viewModel.errorMessage, "Fake failure")
            XCTAssertFalse(viewModel.isLoading)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
