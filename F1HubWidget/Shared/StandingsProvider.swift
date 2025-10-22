//
//  StandingsProvider.swift
//  F1Hub
//
//  Created by Marcos Morales on 21/10/2025.
//

import Foundation
import WidgetKit

struct StandingsProvider: TimelineProvider {
    let type: StandingsType

    func placeholder(in context: Context) -> StandingsTimelineEntry {
        StandingsTimelineEntry(
            date: Date(),
            standings: StandingsEntry.mock(for: type),
            type: type
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (StandingsTimelineEntry) -> Void) {
        let entry = placeholder(in: context)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<StandingsTimelineEntry>) -> Void) {
        Task {
            do {
                let service = F1APIService()
                let standings = try await { () async throws -> [StandingsEntry] in
                    switch type {
                    case .drivers:
                        return try await service.fetchCurrentDriversStandings()
                    case .teams:
                        return try await service.fetchCurrentTeamsStandings()
                    }
                }()
                let entry = StandingsTimelineEntry(date: Date(), standings: standings, type: type)
                let timeline = Timeline(
                    entries: [entry],
                    policy: .after(Date().addingTimeInterval(3600)) // Refresh every hour
                )
                completion(timeline)
            } catch {
                let entry = placeholder(in: context)
                let timeline = Timeline(entries: [entry], policy: .atEnd)
                completion(timeline)
            }
        }
    }
}
