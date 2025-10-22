//
//  StandingsType.swift
//  F1Hub
//
//  Created by Marcos Morales on 21/10/2025.
//

enum StandingsType: String, Codable, CaseIterable {
    case drivers
    case teams
}

extension StandingsEntry {
    static func mock(for type: StandingsType) -> [StandingsEntry] {
        switch type {
        case .drivers:
            return mockDriversStandings()
        case .teams:
            return mockTeamsStandings()
        }
    }
}
