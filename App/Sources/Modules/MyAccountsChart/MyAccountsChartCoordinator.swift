//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import UIKit

final class MyAccountsChartCoordinator: Coordinator {
    var parent: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.setupNavigationController()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func start() {
        let myAccountsChartViewController: MyAccountsChartViewController = .loadControllerFromNib()
        _ = MyAccountsChartViewModel(controller: myAccountsChartViewController)
        myAccountsChartViewController.title = "Ma répartition"
        navigationController?.setViewControllers([myAccountsChartViewController], animated: false)
    }
}
