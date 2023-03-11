//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import Foundation

enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum Endpoint {
    case getAccounts

    var method: Method {
        switch self {
        case .getAccounts:
            return .get
        }
    }

    var urlRequest: URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = "/\(path)"
        components.queryItems = queryItems
        
        guard let url = components.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        return request
    }
    
    var headers: [String: String] {
        [:]
    }
    
    private var host: String {
        switch self {
        case .getAccounts:
            return "cdf-test-mobile-default-rtdb.europe-west1.firebasedatabase.app"
        }
    }
    
    private var path: String {
        switch self {
        case .getAccounts:
            return "banks.json"
        }
    }
    
    var queryItems: [URLQueryItem] {
        []
    }
    
    var mockData: Data {
        switch self {
        case .getAccounts:
            return Bundle.module.data(file: "GetMyAccounts")
        }
    }
}
