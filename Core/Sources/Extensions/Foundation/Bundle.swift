//
//  Bundle.swift
//  
//

import Foundation

extension Bundle {
    func data(file: String, ofType type: String = "json") -> Data {
        guard let url = url(forResource: file, withExtension: type) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        return data
    }
    
    public func decode<T: Decodable>(file: String) -> T {
        guard let model = try? JSONDecoder().decode(T.self, from: data(file: file)) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        return model
    }
}
