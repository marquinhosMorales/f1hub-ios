//
//  Session.swift
//  F1Hub
//
//  Created by Marcos Morales on 24/04/2025.
//

struct RaceSession: Codable {
    let date: String?
    let time: String?
    
    enum CodingKeys: String, CodingKey {
        case date
        case time
    }
}
