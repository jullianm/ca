//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import Foundation

public protocol APIService {
    func fetch<T: Decodable>(endpoint: Endpoint, model: T.Type) async -> Result<T, APIError>
}

extension URLSession: APIService {
    public func fetch<T: Decodable>(endpoint: Endpoint, model: T.Type) async -> Result<T, APIError> {
        guard let request = endpoint.urlRequest else {
            return .failure(.badURL)
        }
        
        do {
            let (data, response) = try await data(for: request)
            try validateResponse(data: data, response)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let model = try decoder.decode(model, from: data)
            return .success(model)
        } catch let error {
            if let nsError = error as NSError? {
                switch nsError.code {
                case NSURLErrorTimedOut:
                    return .failure(.timeout)
                case NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet, NSURLErrorDataNotAllowed, NSURLErrorInternationalRoamingOff:
                    return .failure(.network)
                default:
                    return .failure(.unknown(error))
                }
                
            } else {
                return .failure(.unknown(error))
            }
        }
    }
    
    private func validateResponse(data: Data, _ response: URLResponse) throws {
        let statusCode = ((response as? HTTPURLResponse)?.statusCode).or(500)
        let isValid = 200..<300 ~= statusCode
        
        guard isValid else {
            throw APIError.badResponse(response)
        }
    }
}

