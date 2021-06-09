//
//  FlightControllerBuilder.swift
//  KiwiApp
//
//  Created by Branko Ivandekic on 6/8/21.
//

import Foundation
import UIKit

class FlightSource {

    func getFlights(completion: @escaping (Result<[FlightViewModel], Error>) -> Void) {
        DataController.default.flights.get { result in
            switch result {
            case .success(let flights):
                let offer = flights.resolveDailyOffer()
                let viewModels = offer.map{FlightViewModel(flight: $0)}
                completion(.success(viewModels))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private extension Array where Element == GetFlightsReponse.Flight {
    func  resolveDailyOffer() -> [GetFlightsReponse.Flight] {
        let currentDate = Date()
        if let storedDate = Storage.shared.offerStamp?.date,
           Calendar.current.dateComponents([.day], from: storedDate, to: currentDate).day == 0 {
            return getStoredFlights()
        } else {
            return createNewOffer()
        }
    }

    private func  getStoredFlights() -> [GetFlightsReponse.Flight] {
        guard let storedFlights = Storage.shared.offerStamp?.ids else {return [GetFlightsReponse.Flight]()}
        return self.filter{storedFlights.contains($0.id)}
    }

    private func createNewOffer() -> [GetFlightsReponse.Flight] {
        let excludedIds = Storage.shared.offerStamp?.ids ?? [String]()
        let availableSelection = self.filter{!excludedIds.contains($0.id)}
        let selectedFlights = Array(availableSelection.shuffled().prefix(5))
        let newStamp = OfferStamp(date: Date(), ids: selectedFlights.map{$0.id})
        Storage.shared.offerStamp = newStamp
        return selectedFlights
    }
}
