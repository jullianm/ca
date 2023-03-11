//
//  MyOperationCell.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import UIKit

final class MyOperationCell: UITableViewCell {
    @IBOutlet private weak var operationTitleLabel: UILabel!
    @IBOutlet private weak var operationDateLabel: UILabel!
    @IBOutlet private weak var operationAmountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
    }

    func configure(operation: MyAccountOperationUIModel) {
        operationTitleLabel.text = operation.title
        operationDateLabel.text = operation.date
        operationAmountLabel.text = operation.amount
    }
}
