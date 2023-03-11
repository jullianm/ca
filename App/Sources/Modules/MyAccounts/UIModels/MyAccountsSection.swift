//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import Foundation

enum MyAccountsSection {
    case ca(MyAccountsSectionUIModel)
    case others(MyAccountsSectionUIModel)
}

struct MyAccountsSectionUIModel {
    let header: String
    let rows: [MyAccountsRow]
}
