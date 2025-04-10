//
//  DriverListViewModel.swift
//  F1Hub
//
//  Created by Marcos Morales on 10/04/2025.
//

import Foundation

class DriverListViewModel: ObservableObject {
    @Published var data: [Driver] = []
    
    func fetchDrivers() {
        let max = Driver(driverId: "max_verstappen", name: "Max", surname: "Verstappen", nationality: "Netherlands", birthday: "30/09/1997", number: 33, shortName: "VER", url: "https://en.wikipedia.org/wiki/Max_Verstappen", teamId: "red_bull")
        let lando = Driver(driverId: "norris", name: "Lando", surname: "Norris", nationality: "Great Britain", birthday: "13/11/1999", number: 4, shortName: "NOR", url: "https://en.wikipedia.org/wiki/Lando_Norris", teamId: "mclaren")
        data = [max, lando]
    }
}
