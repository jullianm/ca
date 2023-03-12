//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import UIKit

final class MyOperationsCoordinator: Coordinator {
    var parent: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController?
    private var operations: MyAccountDetailsUIModel
    
    init(navigationController: UINavigationController?, operations: MyAccountDetailsUIModel) {
        self.navigationController = navigationController
        self.operations = operations
    }
    
    func start() {
        let myOperationsViewController: MyOperationsViewController = .loadControllerFromNib()
        _ = MyOperationsViewModel(controller: myOperationsViewController, operations: operations)
        navigationController?.pushViewController(myOperationsViewController, animated: true)
    }
}
