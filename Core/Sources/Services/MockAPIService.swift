//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import Foundation

public final class MockAPIService: APIService {
    public init() {}
    
    public var apiError: APIError?
    
    public func fetch<T: Decodable>(endpoint: Endpoint, model: T.Type) async -> Result<T, APIError> {
        if let apiError {
            return .failure(apiError)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let model = try decoder.decode(model, from: endpoint.mockData)
            return .success(model)
        } catch let error {
            return .failure(.corruptedData(error))
        }
    }
}
