//
//  MyAccountsChartViewController.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import UIKit
import Charts

protocol MyAccountsChartViewPresentable: AnyObject {
    var viewModel: MyAccountsChartViewModelable? { get set }
    
    func presentChart(uiModel: MyAccountsChartUIModel)
    func presentErrorMessage(_ errorMessage: String)
}

final class MyAccountsChartViewController: UIViewController, MyAccountsChartViewPresentable {
    @IBOutlet private weak var pieChartView: PieChartView!
    
    var viewModel: MyAccountsChartViewModelable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDatasource()
    }
    
    private func fetchDatasource() {
        Task {
            await viewModel?.fetchMyAccounts()
        }
    }
    
    func presentChart(uiModel: MyAccountsChartUIModel) {
        pieChartView.data = uiModel.pieChartData
        pieChartView.legend.horizontalAlignment = .center
        pieChartView.holeRadiusPercent = 0.55
        pieChartView.chartDescription.enabled = false
        pieChartView.legend.enabled = false
        pieChartView.animate(yAxisDuration: 0.5, easingOption: .easeInBack)
    }
    
    func presentErrorMessage(_ errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
