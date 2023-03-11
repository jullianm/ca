import XCTest
@testable import Core

class APITests: XCTestCase {
    var sut: APIService!

    override func setUpWithError() throws {
        sut = MockAPIService()
    }
    
    func testGetMyAccountsSuccess() async throws {
        // Given
        let endpoint = Endpoint.getAccounts
        
        // When
        let result = try await sut.fetch(endpoint: endpoint, model: [MyAccounts].self)
        
        // Then
        switch result {
        case .success(let model):
            XCTAssertEqual(model.isEmpty, false)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }
    
}
