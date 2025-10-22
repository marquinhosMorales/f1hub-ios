//
//  TeamsStandingsEntry.swift
//  F1Hub
//
//  Created by Marcos Morales on 21/10/2025.
//

import SwiftUI
import WidgetKit

struct TeamsStandingsWidget: Widget {
    let kind: String = "TeamsStandings"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: StandingsProvider(type: .teams)) { entry in
            StandingsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Teams Standings")
        .description("Current teams championship standings.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview("Small Widget", as: .systemSmall) {
    TeamsStandingsWidget()
} timeline: {
    StandingsTimelineEntry(
        date: Date(),
        standings: StandingsEntry.mockDriversStandings(),
        type: .teams
    )
}

#Preview("Medium Widget", as: .systemMedium) {
    TeamsStandingsWidget()
} timeline: {
    StandingsTimelineEntry(
        date: Date(),
        standings: StandingsEntry.mockDriversStandings(),
        type: .teams
    )
}
