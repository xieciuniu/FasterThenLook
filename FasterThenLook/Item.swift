//
//  Item.swift
//  FasterThenLook
//
//  Created by Hubert Wojtowicz on 19/07/2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
