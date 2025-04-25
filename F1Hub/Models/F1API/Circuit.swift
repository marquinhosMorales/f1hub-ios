//
//  Circuit.swift
//  F1Hub
//
//  Created by Marcos Morales on 25/04/2025.
//

struct Circuit: Codable, Identifiable {
    let circuitId: String
    let circuitName: String
    let country: String
    let city: String
    let circuitLength: String
    let lapRecord: String
    let firstParticipationYear: Int
    let corners: Int
    let fastestLapDriverId: String
    let fastestLapTeamId: String
    let fastestLapYear: Int
    let url: String

    // Computed property for Identifiable
    var id: String { circuitId }

    enum CodingKeys: String, CodingKey {
        case circuitId
        case circuitName
        case country
        case city
        case circuitLength
        case lapRecord
        case firstParticipationYear
        case corners
        case fastestLapDriverId
        case fastestLapTeamId
        case fastestLapYear
        case url
    }
}
