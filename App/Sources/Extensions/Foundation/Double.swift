//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import Foundation

extension Double {
    var formattedAmount: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 2
        formatter.minimumIntegerDigits = 1
        formatter.currencySymbol = "€"
        
        let formattedNumber = formatter.string(from: NSNumber(value: self))
        
        return formattedNumber
    }
    
    var formattedDate: String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateStyle = .short
        
        return formatter.string(from: Date(timeIntervalSince1970: self))
    }
}
