//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import Foundation

enum MyAccountsRow {
    case accountsSummary(MyAccountsSummaryUIModel)
    case accountDetails(MyAccountDetailsUIModel)
}

struct MyAccountsSummaryUIModel {
    let bankId: UUID
    let bankSubsidiaryName: String
    let totalBalance: String
}

struct MyAccountDetailsUIModel {
    let bankId: UUID
    let name: String
    let balance: String
    let operations: [MyAccountOperationUIModel]
}

struct MyAccountOperationUIModel {
    let title: String
    let amount: String
    let date: String
}
