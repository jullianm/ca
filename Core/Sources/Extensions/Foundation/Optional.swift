//
//  Optional.swift
//  
//

import Foundation

/// Allows to match for optionals with generics that are defined as non-optional.
protocol AnyOptional {
    /// Returns `true` if `nil`, otherwise `false`.
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    func or(_ defaultValue: Wrapped) -> Wrapped {
        switch self {
        case let .some(value):
            return value
        case .none:
            return defaultValue
        }
    }
    
    public var isNil: Bool { self == nil }
}
