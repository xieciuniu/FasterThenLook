//
//  AppToolbar.swift
//  FasterThenLook
//
//  Created by Hubert Wojtowicz on 29/07/2026.
//

import SwiftUI

private struct AppToolbar: ViewModifier {
    @Environment(AppState.self) private var appState

    func body(content: Content) -> some View {
        @Bindable var appState = appState
        content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Map", systemImage: "mappin") {
                        appState.showingMap = true
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Settings", systemImage: "gearshape") {
                        appState.showingSettings = true
                    }
                }
            }
    }
}

extension View {
    func appToolbar() -> some View {
        modifier(AppToolbar())
    }
}
