//
//  CurrentRacesResponse.swift
//  F1Hub
//
//  Created by Marcos Morales on 24/04/2025.
//

struct CurrentRacesResponse: Codable {
    let season: Int
    let races: [Race]
}
