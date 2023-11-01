//
//  APIError.swift
//  Countries
//
//  Created by Omar Hesham on 9/18/23.
//

import Foundation

//enum APIError: Error {
//    case invalidURL
//    case decodingError
//}

enum APIError: Error {
    case invalidURL
    case decodingError
    case networkError(Error)
}

extension APIError {
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "The provided link seems to be incorrect. Please try again later."
        case .decodingError:
            return "There was an issue processing the data. Please try again later."
        case .networkError:
            return "There was a problem connecting to the server. Please check your connection and try again."
        }
    }
}
