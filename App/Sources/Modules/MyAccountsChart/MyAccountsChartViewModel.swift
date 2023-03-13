//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import Core
import UIKit
import Foundation
import Charts

protocol MyAccountsChartViewModelable: AnyObject {
    @MainActor func fetchMyAccounts() async
}

final class MyAccountsChartViewModel: MyAccountsChartViewModelable {
    private unowned var controller: MyAccountsChartViewPresentable
    private let service: APIService
    
    init(controller: MyAccountsChartViewPresentable, service: APIService = MockAPIService()) {
        self.controller = controller
        self.service = service
        self.controller.viewModel = self
    }
    
    @MainActor
    func fetchMyAccounts() async {
        let result = await service.fetch(endpoint: .getAccounts, model: [MyAccounts].self)
        
        switch result {
        case .success(let models):
            let uiModel = getChartUIModel(models: models)
            controller.presentChart(uiModel: uiModel)
        case .failure(let error):
            controller.presentErrorMessage(error.localizedDescription)
        }
    }
    
    private func getChartUIModel(models: [MyAccounts]) -> MyAccountsChartUIModel {
        let chartEntries = models.reduce(into: [PieChartDataEntry]()) { partialResult, bank in
            let totalBalance = bank.accounts.map { $0.balance }.reduce(0, +)
            let entry = PieChartDataEntry()
            entry.y = totalBalance
            entry.label = bank.name
            partialResult.append(entry)
        }

        let pieChartDataSet = PieChartDataSet(entries: chartEntries, label: "My Accounts")
        
        var colors: [UIColor] = []
        for _ in 0..<chartEntries.count {
            let red = Double(arc4random_uniform(255))
            let green = Double(arc4random_uniform(255))
            let blue = Double(arc4random_uniform(255))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
         
        pieChartDataSet.colors = colors
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartDataSet.valueFormatter = YAxisValueFormatter()

        return .init(pieChartData: pieChartData)
    }
}
