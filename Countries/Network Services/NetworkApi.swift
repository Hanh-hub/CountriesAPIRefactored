//
//  NetworkApi.swift
//  Countries
//
//  Created by Omar Hesham on 9/18/23.
//

import Foundation


//class NetworkApi {
//    
//    func fetchData<T: Decodable>(url: String) async throws -> T {
//        guard let finalURL = URL(string: url) else {
//            throw APIError.invalidURL
//        }
//        
//        do {
//            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: finalURL))
//            let dataModel = try JSONDecoder().decode(T.self, from: data)
//            return dataModel
//        } catch {
//            throw APIError.decodingError
//        }
//            
//    }
//}

class NetworkApi {
    
    func fetchData<T: Decodable>(url: String) async throws -> T {
        guard let finalURL = URL(string: url) else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: finalURL))
            return try JSONDecoder().decode(T.self, from: data)
        } catch is DecodingError {
            throw APIError.decodingError
        } catch let urlSessionError {
            throw APIError.networkError(urlSessionError)
        }
    }
}
