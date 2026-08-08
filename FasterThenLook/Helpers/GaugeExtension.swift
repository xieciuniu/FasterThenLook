//
//  GaugeExtension.swift
//  FasterThenLook
//
//  Created by Hubert Wojtowicz on 31/07/2026.
//

import Foundation
import SwiftUI

struct CarStyleGauge: View {

    // MARK: - Public configuration
    var value: Double
    var range: ClosedRange<Double>
    var unit: String = ""
    var trackColor: Color = Color.gray.opacity(0.25)
    var progressGradient: [Color] = [.green, .yellow, .red]
    var needleColor: Color = .black
    /// Color the value label switches to when `value` falls outside `range`.
    var overRangeColor: Color = .red

    // Matches the sweep used by the system accessoryCircular gauge style:
    // a 270° arc with a 90° gap centered at the bottom.
    private let startAngle: Double = 135
    private let endAngle: Double = 405   // = 45 + 360 (270° sweep)

    // The needle/arc physically can't go past the ends of the dial, so they
    // stay clamped to range — but the text label shows the real value.
    private var clampedValue: Double {
        min(max(value, range.lowerBound), range.upperBound)
    }

    private var isOverRange: Bool {
        value > range.upperBound || value < range.lowerBound
    }

    private var progress: Double {
        (clampedValue - range.lowerBound) / (range.upperBound - range.lowerBound)
    }

    private var needleAngle: Double {
        startAngle + progress * (endAngle - startAngle)
    }

    var body: some View {
        GeometryReader { geo in
            // Reserve a strip below the ring so the min/max labels have
            // somewhere to live that isn't on top of the arc/ticks.
            let labelReserve = min(geo.size.width, geo.size.height) * 0.16
            let size = min(geo.size.width, geo.size.height - labelReserve)
            let lineWidth = size * 0.09
            let radius = (size - lineWidth) / 2
            // Ring is centered in the space above the reserved label strip.
            let center = CGPoint(x: geo.size.width / 2, y: size / 2)

            ZStack {
                // Everything ring-related is grouped and pinned to `center`
                // explicitly, so it stays put regardless of what else is in
                // the view (like the label strip below it).
                Group {
                    // Background track (270° arc, matching accessoryCircular)
                    Circle()
                        .trim(from: 0, to: 0.75)
                        .stroke(trackColor, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                        .rotationEffect(.degrees(startAngle))

                    // Filled portion up to the current value
                    Circle()
                        .trim(from: 0, to: 0.75 * progress)
                        .stroke(
                            // NOTE: this must be defined in the same LOCAL angle
                            // frame as the trim above (0°...sweep), not in the
                            // final on-screen frame — the trailing
                            // .rotationEffect(startAngle) moves both the trim
                            // and the gradient into place together. Defining
                            // the gradient at (startAngle...endAngle) here would
                            // sample the wrong slice of the gradient and scramble
                            // the color order.
                            AngularGradient(
                                colors: progressGradient,
                                center: .center,
                                startAngle: .degrees(0),
                                endAngle: .degrees(endAngle - startAngle)
                            ),
                            style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                        )
                        .rotationEffect(.degrees(startAngle))

                    // Small tick marks around the rim for an instrument-cluster feel
                    ForEach(0..<11) { i in
                        let t = Double(i) / 10
                        let angle = startAngle + t * (endAngle - startAngle)
                        Rectangle()
                            .fill(Color.primary.opacity(0.35))
                            .frame(width: lineWidth * 0.12, height: lineWidth * 0.35)
                            .offset(y: -(radius - lineWidth * 0.9))
                            .rotationEffect(.degrees(angle + 90))
                    }

                    // Needle
                    Needle()
                        .fill(needleColor)
                        .frame(width: lineWidth * 0.32, height: radius * 0.9)
                        .offset(y: -radius * 0.45)
                        .rotationEffect(.degrees(needleAngle + 90))
                        .animation(.spring(response: 0.5, dampingFraction: 0.8), value: needleAngle)

                    // Hub
                    Circle()
                        .fill(needleColor)
                        .frame(width: lineWidth * 0.55, height: lineWidth * 0.55)

                    // Current (real, unclamped) value shown below the hub,
                    // in the gap at the bottom of the ring.
                    VStack(spacing: 0) {
                        Text(formatted(value))
                            .font(.system(size: size * 0.13, weight: .bold, design: .rounded))
                            .foregroundStyle(isOverRange ? overRangeColor : .primary)
                        if !unit.isEmpty {
                            Text(unit)
                                .font(.system(size: size * 0.06, weight: .medium))
                                .foregroundStyle(isOverRange ? overRangeColor : .secondary)
                        }
                    }
                    .offset(y: radius * 0.62)
                }
                .frame(width: size, height: size)
                .position(center)

                // Min/max labels live in their own reserved strip below the
                // ring, so they never sit on top of the arc or ticks.
                HStack {
                    Text(formatted(range.lowerBound))
                    Spacer()
                    Text(formatted(range.upperBound))
                }
                .font(.system(size: size * 0.075, weight: .semibold))
                .foregroundStyle(.secondary)
                .frame(width: size * 0.86)
                .position(x: geo.size.width / 2, y: size - 15 + labelReserve / 2)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }

    private func pointOnCircle(center: CGPoint, radius: CGFloat, angle: Double) -> CGPoint {
        let rad: Double = angle * .pi / 180
        let dx: Double = Double(radius) * cos(rad)
        let dy: Double = Double(radius) * sin(rad)
        return CGPoint(x: center.x + CGFloat(dx), y: center.y + CGFloat(dy))
    }

    private func formatted(_ v: Double) -> String {
        v.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(v)) : String(format: "%.1f", v)
    }
}

/// A simple upward-pointing triangular needle.
private struct Needle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width / 2, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        return path
    }
}

// MARK: - Preview / usage examples

#Preview {
    VStack(spacing: 40) {
        HStack(spacing: 30) {
            CarStyleGauge(value: 72, range: 0...120, unit: "km/h")
                .frame(width: 140, height: 140)

            CarStyleGauge(
                value: 7200,
                range: 0...7000,
                unit: "rpm",
                progressGradient: [.blue, .green, .orange, .red]
            )
            .frame(width: 140, height: 140)
        }

        CarStyleGauge(value: 15, range: 0...30, unit: "l/100km")
            .frame(width: 200, height: 200)
        CarStyleGauge(
            value: 90,
            range: 0...100,
            unit: "mpg",
            progressGradient: [.red, .orange, .yellow, .green]
        )
            .frame(width: 200, height: 200)
    }
    .padding()
}
