//
//  Race.swift
//  F1Hub
//
//  Created by Marcos Morales on 24/04/2025.
//

import Foundation

struct Race: Codable, Identifiable {
    let raceId: String
    let championshipId: String
    let raceName: String
    let laps: Int
    let round: Int
    let url: String

    // Computed property for Identifiable
    var id: String { raceId }
    
    let schedule: RaceSchedule
    let circuit: Circuit
    let fastLap: RaceFastLap?
    let winner: Driver?
    let teamWinner: Team?

    enum CodingKeys: String, CodingKey {
        case raceId
        case championshipId
        case raceName
        case laps
        case round
        case url
        case schedule
        case circuit
        case fastLap = "fast_lap"
        case winner
        case teamWinner
    }
}

extension Race {
    static let mockAustralia = Race(
        raceId: "australian_2025",
        championshipId: "f1_2025",
        raceName: "Louis Vuitton Australian Grand Prix 2025",
        laps: 58,
        round: 1,
        url: "https://en.wikipedia.org/wiki/2025_Australian_Grand_Prix",
        schedule:
            RaceSchedule(
                race: RaceSession(date: "2025-03-16", time: "04:00:00Z"),
                qualy: RaceSession(date: "2025-03-15", time: "05:00:00Z"),
                fp1: RaceSession(date: "2025-03-14", time: "01:30:00Z"),
                fp2: nil,
                fp3: nil,
                sprintQualy: nil,
                sprintRace: nil
            ),
        circuit:
            Circuit(
                circuitId: "albert_park",
                circuitName: "Albert Park Circuit",
                country: "Australia",
                city: "Melbourne",
                circuitLength: "5278km",
                lapRecord: "1:19:813",
                firstParticipationYear: 1996,
                corners: 14,
                fastestLapDriverId: "leclerc",
                fastestLapTeamId: "ferrari",
                fastestLapYear: 2024,
                url: "https://en.wikipedia.org/wiki/Albert_Park_Circuit"
            ),
        fastLap:
            RaceFastLap(
                time: "1:22.167",
                driverId: "norris",
                treamId: "mclaren"
            ),
        winner:
            Driver(
                driverId: "norris",
                name: "Lando",
                surname: "Norris",
                nationality: nil,
                birthday: "13/11/1999",
                number: 4,
                shortName: "NOR",
                url: "https://en.wikipedia.org/wiki/Lando_Norris",
                teamId: nil,
                country: "Great Britain"
            ),
        teamWinner:
            Team(
                teamId: "mclaren",
                teamName: "McLaren Formula 1 Team",
                country: "Great Britain",
                firstAppearance: 1966,
                constructorsChampionships: 9,
                driversChampionships: 12,
                url: "https://en.wikipedia.org/wiki/McLaren"
            )
    )
    
    static func mockRaces() -> [Race] {
        return [mockAustralia]
    }
}
