//
//  StandingsViewModel.swift
//  F1Hub
//
//  Created by Marcos Morales on 30/04/2025.
//

import Foundation

class StandingsViewModel: BaseViewModel {
    @Published var driversStandings: [StandingsEntry] = []
    @Published var teamsStandings: [StandingsEntry] = []

    private let f1APIService = F1APIService()

    @MainActor
    func fetchCurrentDriversStandings() async {
        state = .loading

        do {
            let standings = try await f1APIService.fetchCurrentDriversStandings()
            driversStandings = standings
            state = .finished
        } catch {
            state = .error(error)
        }
    }

    @MainActor
    func fetchCurrentTeamsStandings() async {
        state = .loading

        do {
            let standings = try await f1APIService.fetchCurrentTeamsStandings()
            teamsStandings = standings
            state = .finished
        } catch {
            state = .error(error)
        }
    }
}
