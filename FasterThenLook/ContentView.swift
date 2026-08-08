//
//  ContentView.swift
//  FasterThenLook
//
//  Created by Hubert Wojtowicz on 19/07/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var appState = AppState()

    var body: some View {
        @Bindable var appState = appState

        TabView(selection: $appState.selectedTab) {
            Tab("Dashboard", systemImage: "house", value: .dashboard) {
                DashboardView()
            }
            Tab("Maintenance", systemImage: "wrench.and.screwdriver", value: .maintenance) {
                MaintenanceView()
            }
            Tab("Fuel Logs", systemImage: "fuelpump", value: .fuelLogs) {
                FuelLogsView()
            }
            Tab("Repairs", systemImage: "hammer", value: .repairs) {
                RepairsView()
            }
            Tab("Garage", systemImage: "car.2", value: .garage) {
                GarageView()
            }
        }
        .environment(appState)
        .sheet(isPresented: $appState.showingSettings) {
            SettingsView()
        }
        .sheet(isPresented: $appState.showingMap) {
            MapView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(
            for: [
                Car.self,
                MaintenanceItem.self,
                FuelLog.self,
                RepairLog.self,
                AppSettings.self
            ],
            inMemory: true
        )
}
