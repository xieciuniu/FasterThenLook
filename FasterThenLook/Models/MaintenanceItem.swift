//
//  MaintenanceItem.swift
//  Ride Up
//
//  Created by Hubert Wojtowicz on 21/06/2026.
//

import Foundation
import SwiftData

@Model
class MaintenanceItem {
    var timeIntervalDays: Int?
    var triggerType: TriggerType
    var mileageInterval: Int?
    var lastServiceDate: Date?
    var lastServiceMileage: Double?
    @Relationship(inverse: \Car.maintenanceItems)
    var car: Car

    init(timeIntervalDays: Int?, triggerType: TriggerType, mileageInterval: Int?, lastServiceDate: Date?, lastServiceMileage: Double?, car: Car){
        self.timeIntervalDays = timeIntervalDays
        self.triggerType = triggerType
        self.mileageInterval = mileageInterval
        self.lastServiceDate = lastServiceDate
        self.lastServiceMileage = lastServiceMileage
        self.car = car
    }
}

nonisolated
enum TriggerType: Codable {
    case time
    case mileage
    case timeOrMileage
}
