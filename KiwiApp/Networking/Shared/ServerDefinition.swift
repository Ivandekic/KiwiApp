//
//  ServerDefinition.swift
//  KiwiApp
//
//  Created by Branko Ivandekic on 6/7/21.
//

import Foundation

typealias RequestHeaders = [String: String]

protocol ServerDefinition {
    var serverScheme: String {get}
    var baseServerURL: String {get}
    var headers: RequestHeaders? {get}
}

class DataServerDefinition: ServerDefinition {
    var baseServerURL: String = "api.skypicker.com"
    var serverScheme: String = "https"
    var headers: RequestHeaders? {
        return nil
    }
}
