//
//  MyAccountsChartViewModelTests.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import XCTest
import Core
@testable import App

final class MyAccountsChartViewModelTests: XCTestCase {
    private var sut: MyAccountsChartViewModel!
    private var mockAPIService: MockAPIService!
    private var controllerMock: MyAccountsChartViewControllerMock!

    override func setUpWithError() throws {
        controllerMock = MyAccountsChartViewControllerMock()
        mockAPIService = MockAPIService()
    }

    override func tearDownWithError() throws {
        controllerMock = nil
        sut = nil
        mockAPIService = nil
    }
    
    func testDidReceiveChartUiModel() async {
        // Given
        sut = MyAccountsChartViewModel(controller: controllerMock, service: mockAPIService)
        
        // When
        await sut.fetchMyAccounts()
        
        // Then
        XCTAssertEqual(controllerMock.chartUiModel.isNil, false)
    }
    
    func testDidReceiveError() async {
        // Given
        mockAPIService.apiError = .badURL
        sut = MyAccountsChartViewModel(controller: controllerMock, service: mockAPIService)
        
        // When
        await sut.fetchMyAccounts()
        
        // Then
        XCTAssertEqual(controllerMock.errorMessage.isNil, false)
    }
}

