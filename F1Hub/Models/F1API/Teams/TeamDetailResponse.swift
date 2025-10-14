//
//  TeamDetailResponse.swift
//  F1Hub
//
//  Created by Marcos Morales on 13/10/2025.
//

struct TeamDetailResponse: Codable {
    let teams: [Team]

    enum CodingKeys: String, CodingKey {
        case teams = "team"
    }
}
