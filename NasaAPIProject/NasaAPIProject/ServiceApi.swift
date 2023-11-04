//
//  ServiceApi.swift
//  NasaAPIProject
//
//  Created by Diego Borrallo Herrero on 4/11/23.
//

import Foundation

class ServiceApi{
    
    enum RequestError: Error, LocalizedError{
        case itemsNotFound
    }
    
    static func fetchItems(url:String, matching query: [String: String]) async throws -> Data{
        
        var urlComponents = URLComponents(string: url)!
        urlComponents.queryItems = query.map{ URLQueryItem(name: $0.key, value: $0.value) }
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else{
            throw RequestError.itemsNotFound
        }
        
        return data
    }
}
