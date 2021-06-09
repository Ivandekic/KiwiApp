//
//  FlightsProtocol.swift
//  KiwiApp
//
//  Created by Branko Ivandekic on 6/7/21.
//

import Foundation

protocol FlightsProtocol {
    func get(completion: @escaping (Result<[GetFlightsReponse.Flight], Error>) -> Void)
}
