//
//  AppSettings.swift
//  Ride Up
//
//  Created by Hubert Wojtowicz on 21/06/2026.
//

import Foundation
import SwiftData

@Model
class AppSettings {
    var distanceUnit: DistanceUnit
    var fuelUnit: FuelUnit
    var economyUnit: EconomyUnit
    var currency: String
    var notifyRepeatDays: Int

    init(distanceUnit: DistanceUnit, fuelUnit: FuelUnit, economyUnit: EconomyUnit, currency: String, notifyRepeatDays: Int){
        self.distanceUnit = distanceUnit
        self.fuelUnit = fuelUnit
        self.economyUnit = economyUnit
        self.currency = currency
        self.notifyRepeatDays = notifyRepeatDays
    }
}

nonisolated
enum DistanceUnit: Codable {
    case miles
    case kilometers
}

nonisolated
enum FuelUnit: Codable {
    case liters
    case gallonsUsa
    case gallonsUK
    case kWh
    case kg
    case m3
}

nonisolated
enum EconomyUnit: Codable {
    case litersPer100km
    case milesPerGallon
    case kmPerLiter
    case kWhPer100km
    case milesPerKWh
    case whPerKm
}
