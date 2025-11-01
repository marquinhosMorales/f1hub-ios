//
//  StandingsEntry.swift
//  F1Hub
//
//  Created by Marcos Morales on 30/04/2025.
//

struct StandingsEntry: Codable, Identifiable, Equatable {
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

    static func == (lhs: StandingsEntry, rhs: StandingsEntry) -> Bool {
        lhs.classificationId == rhs.classificationId &&
            lhs.teamId == rhs.teamId &&
            lhs.points == rhs.points &&
            lhs.position == rhs.position &&
            lhs.wins == rhs.wins &&
            lhs.team == rhs.team &&
            lhs.driverId == rhs.driverId &&
            lhs.driver == rhs.driver
    }

    var isLeader: Bool {
        return position == 1
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

    static let mockLeclercEntry = StandingsEntry(
        classificationId: 3,
        teamId: TeamID.Ferrari,
        points: 25,
        position: 3,
        wins: 1,
        team: Team.mockFerrari,
        driverId: Driver.mockLeclerc.driverId,
        driver: Driver.mockLeclerc
    )

    static let mockRedBullEntry = StandingsEntry(
        classificationId: 1,
        teamId: TeamID.RedBull,
        points: 125,
        position: 1,
        wins: 5,
        team: Team.mockRedBull,
        driverId: nil,
        driver: nil
    )

    static let mockMcLarenEntry = StandingsEntry(
        classificationId: 2,
        teamId: TeamID.McLaren,
        points: 75,
        position: 2,
        wins: 3,
        team: Team.mockMcLaren,
        driverId: nil,
        driver: nil
    )

    static let mockFerrariEntry = StandingsEntry(
        classificationId: 3,
        teamId: TeamID.Ferrari,
        points: 25,
        position: 3,
        wins: 1,
        team: Team.mockFerrari,
        driverId: nil,
        driver: nil
    )

    static func mockDriversStandings() -> [StandingsEntry] {
        return [mockVerstappenEntry, mockNorrisEntry, mockLeclercEntry]
    }

    static func mockTeamsStandings() -> [StandingsEntry] {
        return [mockRedBullEntry, mockMcLarenEntry, mockFerrariEntry]
    }
}
