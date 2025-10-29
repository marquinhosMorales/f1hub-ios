//
//  Schedule.swift
//  F1Hub
//
//  Created by Marcos Morales on 24/04/2025.
//

struct RaceSchedule: Codable, Equatable {
    let race: RaceSession
    let qualy: RaceSession
    let fp1: RaceSession
    let fp2: RaceSession?
    let fp3: RaceSession?
    let sprintQualy: RaceSession?
    let sprintRace: RaceSession?

    enum CodingKeys: String, CodingKey {
        case race
        case qualy
        case fp1
        case fp2
        case fp3
        case sprintQualy
        case sprintRace
    }

    static func == (lhs: RaceSchedule, rhs: RaceSchedule) -> Bool {
        lhs.race == rhs.race &&
            lhs.qualy == rhs.qualy &&
            lhs.fp1 == rhs.fp1 &&
            lhs.fp2 == rhs.fp2 &&
            lhs.fp3 == rhs.fp3 &&
            lhs.sprintQualy == rhs.sprintQualy &&
            lhs.sprintRace == rhs.sprintRace
    }
}
