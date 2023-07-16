//
//  NetworkManager.swift
//  RethinkTakeHome
//
//  Created by David Potashnik on 7/10/23.
//

import Foundation

final class NetworkManager {
 
    static let shared = NetworkManager()
    
    func fetchData<T: Decodable>(for: [T.Type], from url: URL) async throws -> [T] {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw RTError.invalidURL
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([T].self, from: data)
        } catch {
            throw RTError.invalidData
        }
    }
}
