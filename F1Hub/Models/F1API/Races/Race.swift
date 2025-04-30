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
    
    func days() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        
        guard let fp1DateString = schedule.fp1.date,
              let raceDateString = schedule.race.date,
              let fp1Date = formatter.date(from: fp1DateString),
              let raceDate = formatter.date(from: raceDateString) else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        let fp1Day = dateFormatter.string(from: fp1Date)
        let raceDay = dateFormatter.string(from: raceDate)
        
        return "\(fp1Day)-\(raceDay)"
    }
    
    func months() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        formatter.timeZone = TimeZone(identifier: "UTC")
        
        guard let fp1DateString = schedule.fp1.date,
              let raceDateString = schedule.race.date,
              let fp1Date = formatter.date(from: fp1DateString),
              let raceDate = formatter.date(from: raceDateString) else {
            return ""
        }
                
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        let fp1Month = dateFormatter.string(from: fp1Date)
        let raceMonth = dateFormatter.string(from: raceDate)
        
        return fp1Month == raceMonth ? raceMonth : "\(fp1Month)-\(raceMonth)"
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
                treamId: TeamID.McLaren
            ),
        winner: Driver.mockNorris,
        teamWinner: Team.mockMcLaren
    )
    
    static let mockSpain = Race(
        raceId: "spanish_2025",
        championshipId: "f1_2025",
        raceName: "Aramco Gran Premio de España 2025",
        laps: 66,
        round: 9,
        url: "https://en.wikipedia.org/wiki/2025_Spanish_Grand_Prix",
        schedule:
            RaceSchedule(
                race: RaceSession(date: "2025-06-01", time: "13:00:00Z"),
                qualy: RaceSession(date: "2025-05-31", time: "14:00:00Z"),
                fp1: RaceSession(date: "2025-05-30", time: "11:30:00Z"),
                fp2: nil,
                fp3: nil,
                sprintQualy: nil,
                sprintRace: nil
            ),
        circuit:
            Circuit(
                circuitId: "montmelo",
                circuitName: "Circuit de Barcelona-Catalunya",
                country: "Spain",
                city: "Barcelona",
                circuitLength: "4657km",
                lapRecord: "1:16:330",
                firstParticipationYear: 1991,
                corners: 14,
                fastestLapDriverId: "max_verstappen",
                fastestLapTeamId: "red_bull",
                fastestLapYear: 2023,
                url: "https://en.wikipedia.org/wiki/Circuit_de_Barcelona-Catalunya"
            ),
        fastLap:
            RaceFastLap(
                time: nil,
                driverId: nil,
                treamId: nil
            ),
        winner: nil,
        teamWinner: nil
    )
    
    static func mockRaces() -> [Race] {
        return [mockAustralia, mockSpain]
    }
}
