//
//  MyAccountsViewController.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import UIKit

protocol MyAccountsViewPresentable: AnyObject {
    var viewModel: MyAccountsViewModelable? { get set }
    var coordinator: MyAccountsDelegate? { get set }
    
    func presentMyAccounts(_ myAccounts: [MyAccountsSection])
    func presentErrorMessage(_ errorMessage: String)
}

final class MyAccountsViewController: UIViewController, MyAccountsViewPresentable {
    @IBOutlet private weak var tableView: UITableView!

    var viewModel: MyAccountsViewModelable?
    var coordinator: MyAccountsDelegate?
    private var dataSource: [MyAccountsSection] = []
    private var expandedBanks: [UUID: Bool] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchDatasource()
    }
    
    private func fetchDatasource() {
        Task {
            await viewModel?.fetchMyAccounts()
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(MyAccountDetailsCell.self,
                           MyAccountsSummaryCell.self)
        tableView.registerHeaderFooterView(MyAccountsHeaderView.self)
    }
    
    func presentMyAccounts(_ myAccounts: [MyAccountsSection]) {
        dataSource = myAccounts
        tableView.reloadData()
    }
    
    func presentErrorMessage(_ errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension MyAccountsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dataSource[section] {
        case .ca(let uiModel), .others(let uiModel):
            return uiModel.rows.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.section] {
        case let .ca(uiModel), let .others(uiModel):
            let row = uiModel.rows[indexPath.item]
            
            switch row {
            case .accountsSummary(let myAccountsSummaryUIModel):
                let cell: MyAccountsSummaryCell = tableView.dequeueCell(for: indexPath)
                cell.configure(uiModel: myAccountsSummaryUIModel)
                return cell
            case .accountDetails(let myAccountDetailsUIModel):
                let cell: MyAccountDetailsCell = tableView.dequeueCell(for: indexPath)
                cell.configure(uiModel: myAccountDetailsUIModel)
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView: MyAccountsHeaderView = tableView.dequeueHeaderFooterView()
        
        switch dataSource[section] {
        case .ca(let uiModel), .others(let uiModel):
            sectionHeaderView.configure(title: uiModel.header)
        }
                
        return sectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = dataSource[indexPath.section]
        
        switch section {
        case .ca(let myAccountsSectionUIModel), .others(let myAccountsSectionUIModel):
            let row = myAccountsSectionUIModel.rows[indexPath.item]
            
            switch row {
            case .accountDetails(let uiModel):
                return expandedBanks[uiModel.bankId] == true ? 40 : 0
            case .accountsSummary:
                return UITableView.automaticDimension
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = dataSource[indexPath.section]
        
        switch section {
        case .ca(let myAccountsSectionUIModel), .others(let myAccountsSectionUIModel):
            let row = myAccountsSectionUIModel.rows[indexPath.item]
            
            switch row {
            case .accountsSummary(let uiModel):
                tableView.beginUpdates()
                applyUpdates(indexPath: indexPath, selectedBankId: uiModel.bankId)
                tableView.endUpdates()
            case .accountDetails(let uiModel):
                coordinator?.presentOperations(uiModel)
            }
        }
    }
    
    private func applyUpdates(indexPath: IndexPath, selectedBankId: UUID) {
        if expandedBanks.map(\.key).contains(selectedBankId) {
            expandedBanks[selectedBankId]?.toggle()
        } else {
            expandedBanks[selectedBankId] = true
        }
        
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? MyAccountsSummaryCell else { return }
        
        selectedCell.rotateChevron(identity: expandedBanks[selectedBankId] == false)
    }
}
