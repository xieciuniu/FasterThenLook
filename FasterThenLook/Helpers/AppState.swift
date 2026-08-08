//
//  AppState.swift
//  FasterThenLook
//
//  Created by Hubert Wojtowicz on 29/07/2026.
//

import Foundation

@Observable
@MainActor
final class AppState {
    var selectedTab: AppTab = .dashboard

    var selectedCarID: UUID?

    var showingSettings = false
    var showingMap = false
}
