//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import Core
import Foundation

protocol MyAccountsViewModelable: AnyObject {
    @MainActor func fetchMyAccounts() async
}

final class MyAccountsViewModel {
    private unowned var controller: MyAccountsViewControllerPresentable
    private let service: APIService
    
    init(controller: MyAccountsViewControllerPresentable, service: APIService = MockAPIService()) {
        self.controller = controller
        self.service = service
        self.controller.viewModel = self
    }
    
    @MainActor
    func fetchMyAccounts() async {
        let result = await service.fetch(endpoint: .getAccounts, model: [MyAccounts].self)
        
        switch result {
        case .success(let models):
            let uiModels = getUIModels(models: models)
            controller.presentMyAccounts(uiModels)
        case .failure(let error):
            controller.presentErrorMessage(error.localizedDescription)
        }
    }
    
    private func getUIModels(models: [MyAccounts]) -> [MyAccountsSection] {
        let caRows = getMyAccountsRows(models: models.filter { $0.isCA == 1 })
        let othersRows = getMyAccountsRows(models: models.filter { $0.isCA == 0 })
            
        let caSection = MyAccountsSection.ca(.init(header: "Crédit Agricole", rows: caRows))
        let othersSection = MyAccountsSection.others(.init(header: "Autres banques", rows: othersRows))
        
        return [caSection, othersSection]
    }
    
    private func getMyAccountsRows(models: [MyAccounts]) -> [MyAccountsRow] {
        models.reduce(into: [MyAccountsRow]()) { partialResult, bank in
            let totalBalance = bank.accounts.map { $0.balance }.reduce(0, +).rounded
            let bankId = UUID()
            partialResult.append(.accountsSummary(.init(bankId: bankId, bankSubsidiaryName: bank.name, totalBalance: "\(String(totalBalance)) €")))
            
            let accountDetailsRows = bank.accounts
                .sorted(by: { $0.label.lowercased() < $1.label.lowercased() })
                .map { account in
                    let operations = getAccountOperationsUIModels(models: account.operations)
                    let accountDetailsUIModel = MyAccountDetailsUIModel(bankId: bankId, name: account.label, balance: "\(String(account.balance)) €", operations: operations)
                    return MyAccountsRow.accountDetails(accountDetailsUIModel)
                }
 
            partialResult.append(contentsOf: accountDetailsRows)
        }
    }
    
    private func getAccountOperationsUIModels(models: [MyAccounts.Account.Operation]) -> [MyAccountOperationUIModel] {
        models.map { operation in
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            let date = Double(operation.date)!
            let d = Date(timeIntervalSince1970: date)
            
            return MyAccountOperationUIModel(amount: operation.amount, date: formatter.string(from: d))
        }
    }
    
}
