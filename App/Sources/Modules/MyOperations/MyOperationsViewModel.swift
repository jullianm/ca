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
    
    init(controller: MyOperationsViewPresentable, operations: MyAccountDetailsUIModel, coordinator: MyOperationsDelegate) {
        self.controller = controller
        self.operations = operations
        self.controller.viewModel = self
        self.controller.coordinator = coordinator
    }
    
    func fetchOperations() {
        controller.presentMyOperations(operations)
    }
}
