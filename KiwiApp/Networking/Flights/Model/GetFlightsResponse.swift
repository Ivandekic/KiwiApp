//
//  GetFlightsResponse.swift
//  KiwiApp
//
//  Created by Branko Ivandekic on 6/7/21.
//

import Foundation

struct GetFlightsReponse: Decodable {
    let searchId: String
    let currency: String
    let data: [Flight]

    struct Flight: Decodable {
        let id: String
        let flyFrom: String
        let cityFrom: String
        let flyTo: String
        let cityTo: String
        let flyDuration: String
        let price: Int
        let countryTo: DestinationCountry
        let mapIdto: String
        let aTime: Date
        let dTime: Date

        struct DestinationCountry: Decodable {
            let code: String
            let name: String
        }
    }
}
