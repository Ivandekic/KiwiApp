//
//  NetworkError.swift
//  KiwiApp
//
//  Created by Branko Ivandekic on 6/7/21.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case responseError
    case customError(message: String)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL provided"
        case .responseError:
            return "Invalid response"
        case .customError(let message):
            return message
        }
    }
}
