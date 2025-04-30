//
//  CurrentStandingsResponse.swift
//  F1Hub
//
//  Created by Marcos Morales on 30/04/2025.
//

struct CurrentDriversStandingsResponse: Codable {
    let driversStandings: [StandingsEntry]
    
    enum CodingKeys: String, CodingKey {
        case driversStandings = "drivers_championship"
    }
}
