//
//  StandingsTimelineEntry.swift
//  F1Hub
//
//  Created by Marcos Morales on 21/10/2025.
//

import WidgetKit

struct StandingsTimelineEntry: TimelineEntry, Codable {
    let date: Date
    let standings: [StandingsEntry]
    let type: StandingsType
}
