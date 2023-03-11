//
//  Error.swift
//  
//

import Foundation

public enum APIError: Swift.Error {
    case badURL
    case corruptedData(Swift.Error?)
    case decodingError(Swift.Error?)
    case badResponse(URLResponse)
    case network
    case timeout
    case unknown(Error)
}
