//
//  CurrentDriversResponse.swift
//  F1Hub
//
//  Created by Marcos Morales on 12/04/2025.
//

struct CurrentDriversResponse: Codable {
    let season: Int
    let championshipId: String
    let drivers: [Driver]
}
