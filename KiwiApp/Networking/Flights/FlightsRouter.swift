//
//  FlightsRouter.swift
//  KiwiApp
//
//  Created by Branko Ivandekic on 6/7/21.
//

import Foundation

enum FlightsRouter: HTTPRoute {
    case search

    var path: String {
        switch self {
        case .search:
            return "flights"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
}

