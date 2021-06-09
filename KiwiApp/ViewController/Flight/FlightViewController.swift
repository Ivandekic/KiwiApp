//
//  FlightViewController.swift
//  KiwiApp
//
//  Created by Branko Ivandekic on 6/8/21.
//

import UIKit

class FlightViewController: UIViewController {

    @IBOutlet weak var destinationImage: AsyncImageView!
    @IBOutlet weak var flightDetailsView: UIView!
    @IBOutlet weak var destinationNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var departureLabel: UILabel!
    @IBOutlet weak var arrivalLabel: UILabel!
    @IBOutlet weak var departureDate: UILabel!
    @IBOutlet weak var arrivalDate: UILabel!
    @IBOutlet weak var departureTime: UILabel!
    @IBOutlet weak var arrivalTime: UILabel!

    var viewModel: FlightViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInterface()
    }

    private func setUpInterface() {
        setUpViews()
        setUpContent()
    }

    private func setUpViews() {
        flightDetailsView.clipsToBounds = true
        flightDetailsView.layer.cornerRadius = 30
        flightDetailsView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    private func setUpContent() {
        if let url = viewModel.imageURL {
            destinationImage.load(url: url)
        }
        destinationNameLabel.text = viewModel.destinationCityName
        priceLabel.text = viewModel.price
        departureLabel.text = viewModel.departure
        arrivalLabel.text = viewModel.destination
        departureTime.text = viewModel.departureTime
        departureDate.text = viewModel.departureDate
        arrivalTime.text = viewModel.arrivalTime
        arrivalDate.text = viewModel.arrivalDate
    }
}
