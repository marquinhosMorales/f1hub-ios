//
//  RaceFastLap.swift
//  F1Hub
//
//  Created by Marcos Morales on 25/04/2025.
//

struct RaceFastLap: Codable {
    let time: String?
    let driverId: String?
    let treamId: String?
    
    enum CodingKeys: String, CodingKey {
        case time = "fast_lap"
        case driverId = "fast_lap_driver_id"
        case treamId = "fast_lap_team_id"
    }
}
