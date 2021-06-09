//
//  DataController.swift
//  KiwiApp
//
//  Created by Branko Ivandekic on 6/7/21.
//

import Foundation

class DataController {
    static let `default` = DataController()

    lazy var flights = FlightsAdapter()
}
