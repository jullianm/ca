//
//  MyOperationsViewController.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import UIKit

protocol MyOperationsViewPresentable: AnyObject {
    var viewModel: MyOperationsViewModel? { get set }
    
    func presentMyOperations(_ myOperations: MyAccountDetailsUIModel)
}

final class MyOperationsViewController: UIViewController, MyOperationsViewPresentable {
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: MyOperationsViewModel?
    private var accountDetails: MyAccountDetailsUIModel?
    private var operations: [MyAccountOperationUIModel] {
        (accountDetails?.operations).or([])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchOperations()
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MyOperationCell.self)
        
    }
    
    private func fetchOperations() {
        viewModel?.fetchOperations()
    }
    
    func presentMyOperations(_ myOperations: MyAccountDetailsUIModel) {
        accountDetails = myOperations
        let headerView: MyOperationsTableHeaderView = .loadXib()
        headerView.configure(accountBalance: myOperations.balance, accountName: myOperations.name)
        tableView.tableHeaderView = headerView
        tableView.reloadData()
    }
}

extension MyOperationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        operations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyOperationCell = tableView.dequeueCell(for: indexPath)
        let operation = operations[indexPath.item]
        cell.configure(operation: operation)
        return cell
    }
    
}
