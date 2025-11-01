//
//  TeamDetailViewModel.swift
//  F1Hub
//
//  Created by Marcos Morales on 13/10/2025.
//

import SwiftUI

class TeamDetailViewModel: BaseViewModel {
    @Published var team: Team?
    @Published var summary: WikipediaSummary?

    private let f1APIService: F1APIServiceProtocol
    private let wikipediaAPIService: WikipediaAPIServiceProtocol

    private let teamId: String
    let wikiUrl: String

    init(teamId: String, wikiUrl: String, f1APIService: F1APIServiceProtocol = AppDependencyContainer.shared.f1APIService, wikipediaAPIService: WikipediaAPIServiceProtocol = AppDependencyContainer.shared.wikipediaAPIService) {
        self.teamId = teamId
        self.wikiUrl = wikiUrl
        self.f1APIService = f1APIService
        self.wikipediaAPIService = wikipediaAPIService
        super.init()
    }

    @MainActor
    func fetchTeamDetails() async {
        state = .loading
        do {
            // Fetch both in parallel
            async let teamDetailTask: Team = f1APIService.fetchTeamDetail(teamId: teamId)
            async let wikiTask: WikipediaSummary = wikipediaAPIService.fetchSummary(from: wikiUrl)

            // Wait for both to finish
            let (teamResult, wikiResult) = try await (teamDetailTask, wikiTask)

            // Update published vars at the same time
            team = teamResult
            summary = wikiResult

            state = .finished
        } catch {
            state = .error(error)
        }
    }
}
