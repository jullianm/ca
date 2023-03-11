//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import UIKit
@testable import App

final class MyAccountsViewControllerMock: MyAccountsViewControllerPresentable {
    var viewModel: MyAccountsViewModel?
    
    var dataSource: [MyAccountsSection] = []
    var errorMessage: String? = nil
    
    func presentMyAccounts(_ myAccounts: [MyAccountsSection]) {
        dataSource = myAccounts
    }
    
    func presentErrorMessage(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
}
