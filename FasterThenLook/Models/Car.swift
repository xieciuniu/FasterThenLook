//
//  Car.swift
//  FasterThenLook
//
//  Created by Hubert Wojtowicz on 21/06/2026.
//

import Foundation
import SwiftData

@Model
final class Car {
    var make: String
    var model: String
    var name: String
    var year: Int
    var image: Data?
    var vin: String
    var licensePlate: String
    var note: String
    var odometer: Double
    var primaryFuelType: FuelType
    var primaryTankCapacity: Double
    var secondaryFuelType: FuelType?
    var secondaryTankCapacity: Double?
    var isChosen: Bool
    @Relationship(deleteRule: .cascade)
    var maintenanceItems: [MaintenanceItem]
    @Relationship(deleteRule: .cascade)
    var repairLogs: [RepairLog]
    @Relationship(deleteRule: .cascade)
    var fuelLogs: [FuelLog]

    init(
        make: String,
        model: String,
        name: String,
        year: Int,
        image: Data? = nil,
        vin: String,
        licensePlate: String,
        note: String,
        odometer: Double,
        primaryFuelType: FuelType,
        primaryTankCapacity: Double,
        secondaryFuelType: FuelType? = nil,
        secondaryTankCapacity: Double? = nil,
        isChosen: Bool
    ) {
        self.make = make
        self.model = model
        self.name = name
        self.year = year
        self.image = image
        self.vin = vin
        self.licensePlate = licensePlate
        self.note = note
        self.odometer = odometer
        self.primaryFuelType = primaryFuelType
        self.primaryTankCapacity = primaryTankCapacity
        self.secondaryFuelType = secondaryFuelType
        self.secondaryTankCapacity = secondaryTankCapacity
        self.isChosen = isChosen
        self.maintenanceItems = []
        self.repairLogs = []
        self.fuelLogs = []
    }
}

nonisolated
enum FuelType: Codable {
    case petrol
    case diesel
    case liquefiedPetroleumGas
    case electric
    case hydrogen
    case naturalGas
}
