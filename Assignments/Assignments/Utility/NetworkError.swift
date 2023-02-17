//
//  NetworkError.swift
//  Assignments
//
//  Created by Al-Amin on 2023/02/16.
//

import Foundation

enum NetworkError: LocalizedError {
    case networkError(underlyingError: Error)
    case serverError(statusCode: Int)
    case invalidResponse
    case custom(error: Error)
    
    var title: String {
        switch self {
        case .networkError:
            return "Network Error"
        case .serverError:
            return "Server Error"
        case .invalidResponse:
            return "Invalid Response"
        case .custom(let error):
            return error.localizedDescription
        }
    }
    
    var message: String {
        switch self {
        case .networkError(let underlyingError):
            return underlyingError.localizedDescription
        case .serverError(let statusCode):
            return "The server responded with an error \(statusCode). Please try again later."
        case .invalidResponse:
            return "The server responded with an invalid response. Please try again later."
        case .custom:
            return "Please try again later."
        }
    }
}
