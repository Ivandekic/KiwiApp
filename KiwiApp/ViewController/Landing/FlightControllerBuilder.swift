//
//  FlightControllerBuilder.swift
//  KiwiApp
//
//  Created by Branko Ivandekic on 6/8/21.
//

import Foundation
import UIKit

class FlightControllerBuilder {
    func flightController(model: FlightViewModel) -> UIViewController {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(identifier: "FlightViewController")
                as? FlightViewController else {fatalError("Controller not found")}
        viewController.viewModel = model
        return viewController
    }
}
