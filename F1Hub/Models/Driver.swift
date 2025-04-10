//
//  Driver.swift
//  F1Hub
//
//  Created by Marcos Morales on 10/04/2025.
//

import Foundation

struct Driver: Identifiable {
    let id = UUID()
    let driverId: String
    let name: String
    let surname: String
    let nationality: String
    let birthday: Date
    let number: Int
    let shortName: String
    let url: URL?
    let teamId: String
    
    init(driverId: String, name: String, surname: String, nationality: String, birthday: String, number: Int, shortName: String, url: String, teamId: String) {
        self.driverId = driverId
        self.name = name
        self.surname = surname
        self.nationality = nationality
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.birthday = dateFormatter.date(from: birthday) ?? Date()
        
        self.number = number
        self.shortName = shortName
        self.url = URL(string: url)
        self.teamId = teamId
    }
}
