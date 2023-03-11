//
//  MyOperationsViewModelTests.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import XCTest
import Core
@testable import App

final class MyOperationsViewModelTests: XCTestCase {
    private var sut: MyOperationsViewModel!
    private var controllerMock: MyOperationsViewControllerMock!

    override func setUpWithError() throws {
        controllerMock = MyOperationsViewControllerMock()
    }

    override func tearDownWithError() throws {
        controllerMock = nil
        sut = nil
    }
    
    func testDidReceiveDataSource() async {
        // Given
        sut = MyOperationsViewModel(controller: controllerMock, operations: .mock)
        
        // When
        sut.fetchOperations()
        
        // Then
        XCTAssertEqual(controllerMock.dataSource.isNil, false)
    }
}

