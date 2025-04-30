//
//  StandingsViewModel.swift
//  F1Hub
//
//  Created by Marcos Morales on 30/04/2025.
//

import Foundation

class StandingsViewModel: BaseViewModel {
    @Published var data: [StandingsEntry] = []
    
    private let f1APIService = F1APIService()
    
    @MainActor
    func fetchCurrentDriversStandings() async {
        state = .loading
        
        do {
            let standings = try await f1APIService.fetchCurrentDriversStandings()
            data = standings
            state = .finished
        } catch {
            state = .error(error)
        }
    }
}
