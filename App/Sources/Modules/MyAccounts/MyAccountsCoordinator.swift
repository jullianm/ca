//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import UIKit

protocol MyAccountsDelegate: AnyObject {
    func presentOperations(_ operations: MyAccountDetailsUIModel)
}

final class MyAccountsCoordinator: Coordinator {
    var parent: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.setupNavigationController()
    }
    
    private func setupNavigationController() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .systemGroupedBackground
        appearance.shadowColor = .clear

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func start() {
        let myAccountsViewController: MyAccountsViewController = .loadControllerFromNib()
        _ = MyAccountsViewModel(controller: myAccountsViewController, coordinator: self)
        myAccountsViewController.title = "Mes Comptes"
        navigationController?.setViewControllers([myAccountsViewController], animated: false)
    }
}

extension MyAccountsCoordinator: MyAccountsDelegate {
    func presentOperations(_ operations: MyAccountDetailsUIModel) {
        let onFinish: (Coordinator) -> Void = {
            $0.removeFromParent()
        }
        
        let operationsCoordinator = MyOperationsCoordinator(navigationController: navigationController, operations: operations, onFinish: onFinish)
        operationsCoordinator.start()
        addChild(operationsCoordinator)
    }
}
