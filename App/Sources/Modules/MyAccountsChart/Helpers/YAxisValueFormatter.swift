//
//  File.swift
//  
//
//  Created by Jullian Mercier on 12/03/2023.
//

import Foundation
import Charts

final class YAxisValueFormatter: ValueFormatter {
    let formatter: NumberFormatter

    init() {
        formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 2
        formatter.minimumIntegerDigits = 1
        formatter.paddingPosition = .beforePrefix
        formatter.currencySymbol = "€"
    }

    func stringForValue(_ value: Double,
                        entry: ChartDataEntry,
                        dataSetIndex: Int,
                        viewPortHandler: ViewPortHandler?) -> String {
        formatter.string(from: NSNumber(floatLiteral: value))!
    }
}
