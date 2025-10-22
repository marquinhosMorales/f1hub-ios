//
//  Driver.swift
//  F1Hub
//
//  Created by Marcos Morales on 10/04/2025.
//

import Foundation

struct Driver: Codable, Identifiable {
    let driverId: String?
    let name: String
    let surname: String
    let nationality: String?
    let birthday: String
    let number: Int
    let shortName: String
    let url: String
    let teamId: TeamID?
    let country: String?

    // Computed property for Identifiable
    var id: String { driverId ?? String(number) }

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

    var driverName: String {
        return "\(name) \(surname)"
    }

    var age: Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = birthday.contains("/") ? "dd/MM/yyyy" : "yyyy-MM-dd"

        guard let birthDate = formatter.date(from: birthday) else {
            return nil
        }

        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: Date())
        return ageComponents.year
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
        teamId: TeamID.RedBull,
        country: nil
    )

    static let mockVerstappenWikipedia = WikipediaSummary(
        title: "Max Verstappen",
        description: "Dutch and Belgian racing driver (born 1997)",
        extract: "Max Emilian Verstappen is a Dutch and Belgian racing driver who competes under the Dutch flag in Formula One for Red Bull Racing. Verstappen has won four Formula One World Drivers' Championship titles, which he won consecutively from 2021 to 2024 with Red Bull, and has won 67 Grands Prix across 11 seasons.",
        thumbnail: nil,
        originalimage: nil
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
        teamId: TeamID.McLaren,
        country: nil
    )

    static let mockLeclerc = Driver(
        driverId: "leclerc",
        name: "Charles",
        surname: "Leclerc",
        nationality: "Monaco",
        birthday: "16/10/1997",
        number: 16,
        shortName: "LEC",
        url: "https://en.wikipedia.org/wiki/Charles_Leclerc",
        teamId: TeamID.Ferrari,
        country: nil
    )

    static func mockDrivers() -> [Driver] {
        return [mockVerstappen, mockNorris, mockLeclerc]
    }
}
