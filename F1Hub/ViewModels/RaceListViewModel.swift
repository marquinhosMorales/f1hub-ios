//
//  RaceListViewModel.swift
//  F1Hub
//
//  Created by Marcos Morales on 24/04/2025.
//

import Foundation

class RaceListViewModel: BaseViewModel {
    @Published var data: [Race] = []
    
    private let f1APIService = F1APIService()
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter
    }
    
    var upcomingRaces: [Race] {
        data.filter { race in
            guard let raceDateString = race.schedule.race.date,
                  let raceDate = dateFormatter.date(from: raceDateString) else {
                return false
            }
            return raceDate >= Date()
        }
    }
    
    var pastRaces: [Race] {
        data.filter { race in
            guard let raceDateString = race.schedule.race.date,
                  let raceDate = dateFormatter.date(from: raceDateString) else {
                return false
            }
            return raceDate < Date()
        }
    }
    
    @MainActor
    func fetchCurrentraces() async {
        state = .loading
        
        do {
            let races = try await f1APIService.fetchCurrentRaces()
            data = races
            state = .finished
        } catch {
            state = .error(error)
        }
    }
}
