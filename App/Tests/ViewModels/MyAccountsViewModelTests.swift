//
//  MyAccountsViewModelTests.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import XCTest
import Core
@testable import App

final class MyAccountsViewModelTests: XCTestCase {
    private var sut: MyAccountsViewModel!
    private var mockAPIService: MockAPIService!
    private var controllerMock: MyAccountsViewControllerMock!

    override func setUpWithError() throws {
        controllerMock = MyAccountsViewControllerMock()
        mockAPIService = MockAPIService()
    }

    override func tearDownWithError() throws {
        controllerMock = nil
        sut = nil
        mockAPIService = nil
    }
    
    func testDidReceiveDataSource() async {
        // Given
        sut = MyAccountsViewModel(controller: controllerMock, service: mockAPIService)
        
        // When
        await sut.fetchMyAccounts()
        
        // Then
        XCTAssertEqual(controllerMock.dataSource.isEmpty, false)
    }
    
    func testDidReceiveError() async {
        // Given
        mockAPIService.apiError = .badURL
        sut = MyAccountsViewModel(controller: controllerMock, service: mockAPIService)
        
        // When
        await sut.fetchMyAccounts()
        
        // Then
        XCTAssertEqual(controllerMock.errorMessage.isNil, false)
    }

}
