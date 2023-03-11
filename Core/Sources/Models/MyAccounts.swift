//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import Foundation

public struct MyAccounts: Codable {
    public let accounts: [Account]
    public let isCA: Int
    public let name: String
    
    public struct Account: Codable {
        public let balance: Double
        public let contractNumber, holder, id, label: String
        public let operations: [Operation]
        public let order: Int
        public let productCode: String
        public let role: Int
        
        public struct Operation: Codable {
            public let amount, category, date, id: String
            public let title: String
        }
    }
}
