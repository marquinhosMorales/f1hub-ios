//
//  StandingsEntry.swift
//  F1Hub
//
//  Created by Marcos Morales on 30/04/2025.
//

struct StandingsEntry: Codable, Identifiable {
    let classificationId: Int
    let teamId: TeamID
    let points: Int
    let position: Int
    let wins: Int?
    let team: Team
    
    let driverId: String?
    let driver: Driver?

    // Computed property for Identifiable
    var id: String { String(classificationId) }

    enum CodingKeys: String, CodingKey {
        case classificationId
        case teamId
        case points
        case position
        case wins
        case team
        case driverId
        case driver
    }
}

extension StandingsEntry {
    static let mockVerstappenEntry = StandingsEntry(
        classificationId: 1,
        teamId: TeamID.RedBull,
        points: 100,
        position: 1,
        wins: 4,
        team: Team.mockRedBull,
        driverId: Driver.mockVerstappen.driverId,
        driver: Driver.mockVerstappen
    )

    static let mockNorrisEntry = StandingsEntry(
        classificationId: 2,
        teamId: TeamID.McLaren,
        points: 50,
        position: 2,
        wins: 2,
        team: Team.mockMcLaren,
        driverId: Driver.mockNorris.driverId,
        driver: Driver.mockNorris
    )
    
    static func mockStandings() -> [StandingsEntry] {
        return [mockVerstappenEntry, mockNorrisEntry]
    }
}
