//
//  Team.swift
//  F1Hub
//
//  Created by Marcos Morales on 25/04/2025.
//

struct Team: Codable, Identifiable {
    let teamId: String
    let teamName: String
    let country: String
    let firstAppearance: Int
    let constructorsChampionships: Int
    let driversChampionships: Int
    let url: String

    // Computed property for Identifiable
    var id: String { teamId }

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
