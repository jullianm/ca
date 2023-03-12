//
//  MyOperationsTableHeaderView.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import UIKit

final class MyOperationsTableHeaderView: UIView {
    @IBOutlet private weak var accountBalanceLabel: UILabel!
    @IBOutlet private weak var accountNameLabel: UILabel!
    
    func configure(accountBalance: String, accountName: String) {
        accountBalanceLabel.text = accountBalance
        accountNameLabel.text = accountName
    }
}
