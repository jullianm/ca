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
    }
    
    func start() {
        let myAccountsChartViewController: MyAccountsChartViewController = .loadControllerFromNib()
        _ = MyAccountsChartViewModel(controller: myAccountsChartViewController)
        navigationController?.setViewControllers([myAccountsChartViewController], animated: false)
    }
}
