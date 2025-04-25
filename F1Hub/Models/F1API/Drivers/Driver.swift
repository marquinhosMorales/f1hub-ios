//
//  Driver.swift
//  F1Hub
//
//  Created by Marcos Morales on 10/04/2025.
//

import Foundation

struct Driver: Codable, Identifiable {
    let driverId: String
    let name: String
    let surname: String
    let nationality: String?
    let birthday: String
    let number: Int
    let shortName: String
    let url: String
    let teamId: String?
    let country: String?

    // Computed property for Identifiable
    var id: String { driverId }

    enum CodingKeys: String, CodingKey {
        case driverId
        case name
        case surname
        case nationality
        case birthday
        case number
        case shortName
        case url
        case teamId
        case country
    }
}

extension Driver {
    static let mockVerstappen = Driver(
        driverId: "max_verstappen",
        name: "Max",
        surname: "Verstappen",
        nationality: "Netherlands",
        birthday: "30/09/1997",
        number: 33,
        shortName: "VER",
        url: "https://en.wikipedia.org/wiki/Max_Verstappen",
        teamId: "red_bull",
        country: nil
    )

    static let mockNorris = Driver(
        driverId: "norris",
        name: "Lando",
        surname: "Norris",
        nationality: "Great Britain",
        birthday: "13/11/1999",
        number: 4,
        shortName: "NOR",
        url: "https://en.wikipedia.org/wiki/Lando_Norris",
        teamId: "mclaren",
        country: nil
    )
    
    static func mockDrivers() -> [Driver] {
        return [mockVerstappen, mockNorris]
    }
}
