//
//  FlightViewModel.swift
//  KiwiApp
//
//  Created by Branko Ivandekic on 6/8/21.
//

import Foundation

class FlightViewModel {

    private enum Constants {
        static let imageBasePath = "https://images.kiwi.com/photos/600x330/"
        static let imageExtension = ".jpg"
    }

    private (set) var imageURL: URL?
    let destinationCityName: String
    let destination: String
    let departure: String
    let price: String
    let departureTime: String
    let departureDate: String
    let arrivalTime: String
    let arrivalDate: String

    init(flight: GetFlightsReponse.Flight) {
        destinationCityName = flight.cityTo
        destination = "\(flight.cityTo) (\(flight.flyTo))"
        departure = "\(flight.cityFrom) (\(flight.flyFrom))"
        price = "\(flight.price) €"
        departureTime = flight.dTime.displayTime
        departureDate = flight.dTime.displayDate
        arrivalTime = flight.aTime.displayTime
        arrivalDate = flight.aTime.displayDate
        imageURL = imageUrl(flight: flight)
    }

    func imageUrl(flight: GetFlightsReponse.Flight) -> URL? {
        let imageName = flight.mapIdto + Constants.imageExtension
        let fullPath = Constants.imageBasePath + imageName
        if let encodedPath = fullPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            return URL(string: encodedPath)
        } else {
            return nil
        }
    }
}
