//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import UIKit
@testable import App

final class MyOperationsViewControllerMock: MyOperationsViewPresentable {
    var viewModel: MyOperationsViewModel?
    var dataSource: MyAccountDetailsUIModel?
    
    func presentMyOperations(_ myOperations: MyAccountDetailsUIModel) {
        dataSource = myOperations
    }
}
