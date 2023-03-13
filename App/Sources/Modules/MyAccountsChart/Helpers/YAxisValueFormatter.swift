//
//  File.swift
//  
//
//  Created by Jullian Mercier on 12/03/2023.
//

import Foundation
import Charts

final class YAxisValueFormatter: ValueFormatter {
    func stringForValue(_ value: Double,
                        entry: ChartDataEntry,
                        dataSetIndex: Int,
                        viewPortHandler: ViewPortHandler?) -> String {
        value.formatted!
    }
}
