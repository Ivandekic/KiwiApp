//
//  FlightsAdapter.swift
//  KiwiApp
//
//  Created by Branko Ivandekic on 6/7/21.
//

import Foundation

class FlightsAdapter: FlightsProtocol {
    func get(completion: @escaping (Result<[GetFlightsReponse.Flight], Error>) -> Void) {
        let parameters = GetFlightsRequest()
        NetworkController.default.executeGetRequest(route: FlightsRouter.search, parameters: parameters) { (result: Result<GetFlightsReponse, Error>) in
            switch result {
            case .success(let flightsResponse):
                completion(.success(flightsResponse.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
