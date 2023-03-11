//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import Foundation

final class MockAPIService: APIService {
    func fetch<T: Decodable>(endpoint: Endpoint, model: T.Type) async throws -> Result<T, APIError> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let model = try decoder.decode(model, from: endpoint.mockData)
        
        return .success(model)
    }
}
