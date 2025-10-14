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

    private let f1APIService = F1APIService()
    private let wikipediaService = WikipediaAPIService()

    private let teamId: String
    let wikiUrl: String

    init(teamId: String, wikiUrl: String) {
        self.teamId = teamId
        self.wikiUrl = wikiUrl
        super.init()
    }

    @MainActor
    func fetchTeamDetails() async {
        state = .loading
        do {
            // Fetch both in parallel
            async let teamDetailTask: Team = f1APIService.fetchTeamDetail(teamId: teamId)
            async let wikiTask: WikipediaSummary = wikipediaService.fetchSummary(from: wikiUrl)

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
