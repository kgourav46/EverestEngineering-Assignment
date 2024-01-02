//
//  Package.swift
//  DeliveryCost
//
//  Created by Gourav Kumar on 24/12/23.
//

import Foundation

final class Package {
    let id: String
    let weight: Double
    let distance: Double
    let offerCode: OfferCode
    var discount: Double = 0.0
    var totalCost: Double = 0.0
    var deliveryCost: Double = 0.0
    var estimatedDeliveryTime: Double = 0.0

    init(id: String, weight: Double, distance: Double, offerCode: OfferCode) {
        self.id = id
        self.weight = weight
        self.distance = distance
        self.offerCode = offerCode
    }
}

final class Vehicle {
    let maxSpeed: Double
    let maxCarriableWeight: Double
    var currentLoad: Double = 0.0
    var currentTime: Double = 0.0

    init(maxSpeed: Double, maxCarriableWeight: Double) {
        self.maxSpeed = maxSpeed
        self.maxCarriableWeight = maxCarriableWeight
    }
}

enum OfferCode: String {
    case OFR001
    case OFR002
    case OFR003
}
