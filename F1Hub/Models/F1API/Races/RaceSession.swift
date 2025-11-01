//
//  Session.swift
//  F1Hub
//
//  Created by Marcos Morales on 24/04/2025.
//

import Foundation

struct RaceSession: Codable, Equatable {
    let date: String?
    let time: String?

    enum CodingKeys: String, CodingKey {
        case date
        case time
    }

    static func == (lhs: RaceSession, rhs: RaceSession) -> Bool {
        lhs.date == rhs.date &&
            lhs.time == rhs.time
    }

    static func mockSessionDate(daysFromToday: Int) -> String? {
        let timeZone = TimeZone(identifier: "UTC")

        var components = DateComponents()
        components.day = daysFromToday
        components.timeZone = timeZone

        guard let targetDate = Calendar.current.date(byAdding: components, to: Date()) else {
            return nil
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = timeZone
        return formatter.string(from: targetDate)
    }
}
