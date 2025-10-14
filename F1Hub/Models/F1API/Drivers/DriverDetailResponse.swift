//
//  DriverDetailResponse.swift
//  F1Hub
//
//  Created by Marcos Morales on 08/10/2025.
//

struct DriverDetailResponse: Codable {
    let drivers: [Driver]

    enum CodingKeys: String, CodingKey {
        case drivers = "driver"
    }
}
