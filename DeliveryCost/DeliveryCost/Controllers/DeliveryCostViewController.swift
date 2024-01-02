//
//  DeliveryCostViewController.swift
//  DeliveryCost
//
//  Created by Gourav Kumar on 24/12/23.
//

import UIKit

final class DeliveryCostViewController: UIViewController {

    let viewModel = DeliveryCostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let packages = [
            Package(id: "PKG1", weight: 5, distance: 5, offerCode: .OFR001),
            Package(id: "PKG3", weight: 10, distance: 100, offerCode: .OFR003)
        ]

        let vehicles = [
            Vehicle(maxSpeed: 70, maxCarriableWeight: 200),
            Vehicle(maxSpeed: 70, maxCarriableWeight: 200)
        ]

        let baseDeliveryCost = 100

        let resultPackages = viewModel.estimateDeliveryTime(baseDeliveryCost: Double(baseDeliveryCost), packages: packages, vehicles: vehicles)
        debugPrint("Packages \(resultPackages)")
    }
}

