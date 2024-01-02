//
//  DeliveryCostViewModel.swift
//  DeliveryCost
//
//  Created by Gourav Kumar on 02/01/24.
//

import Foundation

final class DeliveryCostViewModel {
    
    func estimateDeliveryTime(baseDeliveryCost: Double,
                              packages: [Package],
                              vehicles: [Vehicle]) -> [Package] {
        var remainingPackages = packages
        let availableVehicles = vehicles

        while !remainingPackages.isEmpty {
            for vehicle in availableVehicles {
                var currentLoad = 0.0
                var currentDistance = 0.0

                // Select packages for delivery based on criteria
                let selectedPackages = remainingPackages.filter { $0.weight + currentLoad <= vehicle.maxCarriableWeight }
                guard !selectedPackages.isEmpty else { continue }

                for pkg in selectedPackages {
                    // Calculate total cost and apply discount
                    let deliveryCost = baseDeliveryCost + (pkg.weight * 10) + (pkg.distance * 5)
                    pkg.deliveryCost = deliveryCost
                    pkg.discount = deliveryCost * calculateDiscount(for: pkg)
                    pkg.totalCost = deliveryCost - pkg.discount

                    // Update current load and distance
                    currentLoad += pkg.weight
                    currentDistance = max(currentDistance, pkg.distance)

                    // Update estimated delivery time
                    pkg.estimatedDeliveryTime = currentDistance / vehicle.maxSpeed

                    // Remove the delivered package
                    if let index = remainingPackages.firstIndex(where: { $0.id == pkg.id }) {
                        remainingPackages.remove(at: index)
                    }
                }

                // Update vehicle status
                vehicle.currentLoad = currentLoad
                vehicle.currentTime += currentDistance / vehicle.maxSpeed

                // Print results
                for pkg in selectedPackages {
                    debugPrint("Package ID: \(pkg.id)")
                    debugPrint("Delivery Cost: \(pkg.deliveryCost)")
                    debugPrint("Discount: \(pkg.discount)")
                    debugPrint("Total Cost: \(pkg.totalCost)")
                    debugPrint("Estimated Delivery Time: \(String(format: "%.2f", pkg.estimatedDeliveryTime))")
                    print("\n<<<<<<<<<<<<<<<========>>>>>>>>>>>>>>>>>>>>>\n")
                }
                debugPrint("Remaining Packages: \(remainingPackages.count)")
                debugPrint("Vehicle \(vehicle) Current Time: \(String(format: "%.2f", vehicle.currentTime)) hrs")
            }
        }

        return packages
    }
    
    private func calculateDiscount(for package: Package) -> Double {
        switch package.offerCode {
        case .OFR001:
            return (package.distance < 200 && package.weight >= 70 && package.weight <= 200) ? 0.1 : 0.0
        case .OFR002:
            return (package.distance >= 50 && package.distance <= 150 && package.weight >= 100 && package.weight <= 250) ? 0.07 : 0.0
        case .OFR003:
            return (package.distance >= 50 && package.distance <= 250 && package.weight >= 10 && package.weight <= 150) ? 0.05 : 0.0
        }
    }
}
