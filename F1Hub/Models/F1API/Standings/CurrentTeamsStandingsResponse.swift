//
//  CurrentTeamsStandingsResponse.swift
//  F1Hub
//
//  Created by Marcos Morales on 30/04/2025.
//

struct CurrentTeamsStandingsResponse: Codable {
    let season: Int
    let championshipId: String
    let teamsStandings: [StandingsEntry]
    
    enum CodingKeys: String, CodingKey {
        case season
        case championshipId
        case teamsStandings = "constructors_championship"
    }
}
