//
//  FuelLog.swift
//  Ride Up
//
//  Created by Hubert Wojtowicz on 21/06/2026.
//

import Foundation
import SwiftData

@Model
class FuelLog {
    var date: Date = Date()
    var odometer: Double
    var isFull: Bool
    var primaryAmount: Double?
    var primaryPricePerUnit: Double?
    var primaryPriceTotal: Double?
    var secondaryAmount: Double?
    var secondaryPricePerUnit: Double?
    var secondaryPriceTotal: Double?
    var primaryEconomy: Double?
    var secondaryEconomy: Double?
    @Relationship(inverse: \Car.fuelLogs)
    var car: Car

    init(
        odometer: Double,
        isFull: Bool,
        primaryAmount: Double? = nil,
        primaryPricePerUnit: Double? = nil,
        primaryPriceTotal: Double? = nil,
        secondaryAmount: Double? = nil,
        secondaryPricePerUnit: Double? = nil,
        secondaryPriceTotal: Double? = nil,
        car: Car
    ) {
        self.odometer = odometer
        self.isFull = isFull
        if let primaryAmount, let primaryPricePerUnit {
            self.primaryEconomy = primaryAmount / primaryPricePerUnit
        }
        self.primaryAmount = primaryAmount
        self.primaryPricePerUnit = primaryPricePerUnit
        self.primaryPriceTotal = primaryPriceTotal
        if let secondaryAmount, let secondaryPricePerUnit {
            self.secondaryEconomy = secondaryAmount / secondaryPricePerUnit
        }
        self.car = car
    }
}
