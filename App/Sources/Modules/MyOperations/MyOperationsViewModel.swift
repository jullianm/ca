//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import Core
import Foundation

protocol MyOperationsViewModelable: AnyObject {
    func fetchOperations()
}

final class MyOperationsViewModel: MyOperationsViewModelable {
    private unowned var controller: MyOperationsViewPresentable
    private let operations: MyAccountDetailsUIModel
    
    init(controller: MyOperationsViewPresentable, operations: MyAccountDetailsUIModel) {
        self.controller = controller
        self.operations = operations
        self.controller.viewModel = self
    }
    
    func fetchOperations() {
        controller.presentMyOperations(operations)
    }
}
