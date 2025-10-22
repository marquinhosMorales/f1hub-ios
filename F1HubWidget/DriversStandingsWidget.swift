//
//  F1HubWidget.swift
//  F1HubWidget
//
//  Created by Marcos Morales on 16/10/2025.
//

import SwiftUI
import WidgetKit

struct DriversStandingsWidget: Widget {
    let kind: String = "DriversStandings"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: StandingsProvider(type: .drivers)) { entry in
            StandingsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Drivers Standings")
        .description("Current drivers championship standings.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview("Small Widget", as: .systemSmall) {
    DriversStandingsWidget()
} timeline: {
    StandingsTimelineEntry(
        date: Date(),
        standings: StandingsEntry.mockDriversStandings(),
        type: .drivers
    )
}

#Preview("Medium Widget", as: .systemMedium) {
    DriversStandingsWidget()
} timeline: {
    StandingsTimelineEntry(
        date: Date(),
        standings: StandingsEntry.mockDriversStandings(),
        type: .drivers
    )
}
