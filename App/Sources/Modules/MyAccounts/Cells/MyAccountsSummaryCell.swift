//
//  MyAccountsSummaryCell.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import UIKit

final class MyAccountsSummaryCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var totalBalanceLabel: UILabel!
    @IBOutlet private weak var chevronImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
    }
    
    func configure(uiModel: MyAccountsSummaryUIModel) {
        titleLabel.text = uiModel.bankSubsidiaryName
        totalBalanceLabel.text = uiModel.totalBalance
    }
    
    func rotateChevron(identity: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            self.chevronImageView.transform = identity ? .identity : CGAffineTransformMakeRotation(.pi)
        })
    }
}
