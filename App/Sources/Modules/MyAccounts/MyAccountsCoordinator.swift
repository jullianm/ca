//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import UIKit

final class MyAccountsCoordinator: Coordinator {
    var parent: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let myAccountsViewController: MyAccountsViewController = .loadControllerFromNib()
        navigationController?.setViewControllers([myAccountsViewController], animated: false)
    }
}
