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

final class MyAccountsViewModel: MyAccountsViewModelable {
    private unowned var controller: MyAccountsViewPresentable
    private let service: APIService
    
    init(controller: MyAccountsViewPresentable, coordinator: MyAccountsDelegate, service: APIService = MockAPIService()) {
        self.controller = controller
        self.service = service
        self.controller.viewModel = self
        self.controller.coordinator = coordinator
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
            
        let caSection = MyAccountsSection.ca(.init(header: "Crédit Agricole",
                                                   rows: caRows))
        
        let othersSection = MyAccountsSection.others(.init(header: "Autres banques",
                                                           rows: othersRows))
        
        return [caSection, othersSection]
    }
    
    private func getMyAccountsRows(models: [MyAccounts]) -> [MyAccountsRow] {
        models.reduce(into: [MyAccountsRow]()) { partialResult, bank in
            let totalBalance = bank.accounts.map { $0.balance }.reduce(0, +).formatted
            let bankId = UUID()
            
            if let totalBalanceText = totalBalance {
                partialResult.append(.accountsSummary(.init(bankId: bankId,
                                                            bankSubsidiaryName: bank.name,
                                                            totalBalance: totalBalanceText)))
                
            }

            let accountDetailsRows = bank.accounts
                .sorted(by: { $0.label.lowercased() < $1.label.lowercased() })
                .compactMap { account in
                    let operations = getAccountOperationsUIModels(models: account.operations)
                    
                    if let balanceText = account.balance.formatted {
                        let accountDetailsUIModel = MyAccountDetailsUIModel(bankId: bankId,
                                                                            name: account.label,
                                                                            balance: balanceText,
                                                                            operations: operations)
                        return MyAccountsRow.accountDetails(accountDetailsUIModel)
                    } else {
                        return nil
                    }
                    
                }
 
            partialResult.append(contentsOf: accountDetailsRows)
        }
    }
    
    private func getAccountOperationsUIModels(models: [MyAccounts.Account.Operation]) -> [MyAccountOperationUIModel] {
        models
            .map { operation in
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "fr_FR")
                formatter.dateStyle = .short
                let date = Double(operation.date).or(Date.timeIntervalSinceReferenceDate)
                
                return MyAccountOperationUIModel(title: operation.title,
                                                 amount: "\(operation.amount) €",
                                                 date: formatter.string(from: Date(timeIntervalSince1970: date)))
            }.sorted {
                if $0.date == $1.date {
                    return $0.title.lowercased() < $1.title.lowercased()
                } else {
                    return $0.date > $1.date
                }
            }
    }
    
}
