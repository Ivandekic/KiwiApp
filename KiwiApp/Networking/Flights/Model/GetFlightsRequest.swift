//
//  GetFlightsRequest.swift
//  KiwiApp
//
//  Created by Branko Ivandekic on 6/7/21.
//

import Foundation

// Explicit values provided for the purposes of this test
struct GetFlightsRequest: Encodable {
    let v: String = "3"
    let sort: String = "popularity"
    let featureName: String = "aggregateResults"
    let asc: String = "0"
    let locale: String = "en"
    let flyFrom: String = "BCN"
    let dateFrom: String = "25/8/2021"
    let dateTo: String = "25/9/2021"
    let partner: String = "skypicker"
    let limit: String = "50"
}
