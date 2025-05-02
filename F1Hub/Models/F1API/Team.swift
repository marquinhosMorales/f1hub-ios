//
//  Team.swift
//  F1Hub
//
//  Created by Marcos Morales on 25/04/2025.
//

import SwiftUI

struct Team: Codable, Identifiable {
    let teamId: TeamID?
    let teamName: String
    let country: String
    let firstAppearance: Int?
    let constructorsChampionships: Int?
    let driversChampionships: Int?
    let url: String

    // Computed property for Identifiable
    var id: String { teamId?.rawValue ?? teamName }

    enum CodingKeys: String, CodingKey {
        case teamId
        case teamName
        case country
        case firstAppearance
        case constructorsChampionships
        case driversChampionships
        case url
    }
}

extension Team {
    static let mockRedBull = Team(
        teamId: TeamID.RedBull,
        teamName: "Red Bull Racing",
        country: "Austria",
        firstAppearance: 2005,
        constructorsChampionships: 6,
        driversChampionships: 8,
        url: "https://en.wikipedia.org/wiki/Red_Bull_Racing"
    )

    static let mockMcLaren = Team(
        teamId: TeamID.McLaren,
        teamName: "McLaren Formula 1 Team",
        country: "Great Britain",
        firstAppearance: 1966,
        constructorsChampionships: 9,
        driversChampionships: 12,
        url: "https://en.wikipedia.org/wiki/McLaren"
    )
    
    static func mockTeams() -> [Team] {
        return [mockRedBull, mockMcLaren]
    }
}

// MARK: - TeamID Enum

enum TeamID: String, Codable, CaseIterable {
    case McLaren = "mclaren"
    case Mercedes = "mercedes"
    case RedBull = "red_bull"
    case Ferrari = "ferrari"
    case Williams = "williams"
    case Haas = "haas"
    case AstonMartin = "aston_martin"
    case RacingBulls = "rb"
    case Alpine = "alpine"
    case Sauber = "sauber"
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = TeamID(rawValue: rawValue) ?? .unknown
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
    
    func name() -> String {
        if self == .RedBull {
            return "Red Bull Racing"
        } else if self == .AstonMartin {
            return "Aston Martin"
        } else if self == .RacingBulls {
            return "Racing Bulls"
        } else if self == .Sauber {
            return "Kick Sauber"
        } else if self == .unknown {
            return ""
        } else {
            return String(describing: self)
        }
    }
    
    func color() -> Color {
        return self == .unknown ? .black : Color(String(describing: self))
    }
}
