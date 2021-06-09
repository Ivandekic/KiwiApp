//
//  HTTPRoute.swift
//  KiwiApp
//
//  Created by Branko Ivandekic on 6/7/21.
//

import Foundation

protocol HTTPRoute {
    var path: String { get }
    var method: HTTPMethod { get }
}

