//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import UIKit
@testable import App

final class MyAccountsChartViewControllerMock: MyAccountsChartViewPresentable {
    var viewModel: MyAccountsChartViewModelable?
    var chartUiModel: MyAccountsChartUIModel? = nil
    var errorMessage: String? = nil
    
    func presentChart(uiModel: MyAccountsChartUIModel) {
        chartUiModel = uiModel
    }
    
    func presentErrorMessage(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
}
