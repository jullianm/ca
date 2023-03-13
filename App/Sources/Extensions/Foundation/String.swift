//
//  File.swift
//  
//
//  Created by Jullian Mercier on 13/03/2023.
//

import Foundation

extension String {
    var formattedAmount: String? {
        let str = replacingOccurrences(of: ",", with: ".")
        let value = Double(str)
        
        guard let value else { return nil }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.currencySymbol = "€"
        
        return formatter.string(from: NSNumber(value: value))
    }
}
