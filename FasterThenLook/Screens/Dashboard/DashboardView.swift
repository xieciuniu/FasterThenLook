//
//  DashboardView.swift
//  FasterThenLook
//
//  Created by Hubert Wojtowicz on 29/07/2026.
//

import SwiftUI

struct DashboardView: View {

    private let gradient = Gradient(colors: [Color.green, .yellow, .red])

    var body: some View {
        ScrollView {
            VStack {
                CarStyleGauge(value: 15, range: 0...30, unit: "l/100km")
                    .frame(width: 300, height: 300)
                    .padding(.top, 20)
            }
        }
    }
}

#Preview {
    DashboardView()
}
