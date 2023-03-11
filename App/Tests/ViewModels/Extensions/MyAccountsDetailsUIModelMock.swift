//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import Foundation
@testable import App

extension MyAccountDetailsUIModel {
    static var mock: Self {
        .init(bankId: UUID(),
              name: "CA",
              balance: "200",
              operations: [
                .init(title: "Netflix", amount: "15,99 €", date: "11/02/2022")
              ])
    }
}
