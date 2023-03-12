//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import UIKit

protocol MyOperationsDelegate: AnyObject {
    func navigateBack()
}

final class MyOperationsCoordinator: Coordinator {
    var parent: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController?
    let onFinish: (Coordinator) -> Void
    private var operations: MyAccountDetailsUIModel
    
    init(navigationController: UINavigationController?, operations: MyAccountDetailsUIModel, onFinish: @escaping (Coordinator) -> Void) {
        self.navigationController = navigationController
        self.operations = operations
        self.onFinish = onFinish
    }
    
    func start() {
        let myOperationsViewController: MyOperationsViewController = .loadControllerFromNib()
        _ = MyOperationsViewModel(controller: myOperationsViewController, operations: operations, coordinator: self)
        navigationController?.pushViewController(myOperationsViewController, animated: true)
    }
}

extension MyOperationsCoordinator: MyOperationsDelegate {
    func navigateBack() {
        onFinish(self)
    }
}
