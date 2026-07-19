//
//  FuelLog.swift
//  FasterThenLook
//
//  Created by Hubert Wojtowicz on 21/06/2026.
//

import Foundation
import SwiftData

@Model
final class FuelLog {
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
        primaryEconomy: Double?,
        secondaryEconomy: Double?,
        car: Car
    ) {
        self.odometer = odometer
        self.isFull = isFull
        self.primaryAmount = primaryAmount
        self.primaryPricePerUnit = primaryPricePerUnit
        self.primaryPriceTotal = primaryPriceTotal
        self.primaryEconomy = primaryEconomy
        self.secondaryEconomy = secondaryEconomy
        self.car = car
    }
}
