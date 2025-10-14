//
//  RaceFastLap.swift
//  F1Hub
//
//  Created by Marcos Morales on 25/04/2025.
//

struct RaceFastLap: Codable {
    let time: String?
    let driverId: String?
    let teamId: TeamID?
    
    enum CodingKeys: String, CodingKey {
        case time = "fast_lap"
        case driverId = "fast_lap_driver_id"
        case teamId = "fast_lap_team_id"
    }
}
