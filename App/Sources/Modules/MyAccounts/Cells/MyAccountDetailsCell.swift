//
//  MyAccountCell.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import UIKit

final class MyAccountDetailsCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var balanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
    }
    
    func configure(uiModel: MyAccountDetailsUIModel) {
        titleLabel.text = uiModel.name
        balanceLabel.text = uiModel.balance
    }
}
