//
//  RepairLog.swift
//  FasterThenLook
//
//  Created by Hubert Wojtowicz on 21/06/2026.
//

import Foundation
import SwiftData

@Model
final class RepairLog {
    var partName: String
    var date: Date
    var mileage: Double
    var priceOfItem: Double?
    var priceOfWork: Double?
    var photo: Data?
    @Relationship
    var linkedMaintenanceItem: MaintenanceItem?
    @Relationship(inverse: \Car.repairLogs)
    var car: Car

    init (
        partName: String,
        date: Date,
        mileage: Double,
        priceOfItem: Double?,
        priceOfWork: Double?,
        photo: Data?,
        linkedMaintenanceItem: MaintenanceItem?,
        car: Car
    ) {
        self.partName = partName
        self.date = date
        self.mileage = mileage
        self.priceOfItem = priceOfItem
        self.priceOfWork = priceOfWork
        self.photo = photo
        self.linkedMaintenanceItem = linkedMaintenanceItem
        self.car = car
    }
}
