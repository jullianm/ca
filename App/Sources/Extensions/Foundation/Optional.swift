//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import Foundation

extension Optional {
    func or(_ defaultValue: Wrapped) -> Wrapped {
        switch self {
        case let .some(value):
            return value
        case .none:
            return defaultValue
        }
    }
}
