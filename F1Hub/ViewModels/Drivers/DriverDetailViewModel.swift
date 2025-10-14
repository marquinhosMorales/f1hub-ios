//
//  DriverDetailViewModel.swift
//  F1Hub
//
//  Created by Marcos Morales on 01/10/2025.
//

import Foundation

class DriverDetailViewModel: BaseViewModel {
    @Published var driver: Driver?
    @Published var summary: WikipediaSummary?

    private let f1APIService = F1APIService()
    private let wikipediaService = WikipediaAPIService()

    private let driverId: String
    let wikiUrl: String

    init(driverId: String, wikiUrl: String) {
        self.driverId = driverId
        self.wikiUrl = wikiUrl
        super.init()
    }

    @MainActor
    func fetchDriverDetails() async {
        state = .loading
        do {
            // Fetch both in parallel
            async let driverDetailTask: Driver = f1APIService.fetchDriverDetail(driverId: driverId)
            async let wikiTask: WikipediaSummary = wikipediaService.fetchSummary(from: wikiUrl)

            // Wait for both to finish
            let (driverResult, wikiResult) = try await (driverDetailTask, wikiTask)

            // Update published vars at the same time
            driver = driverResult
            summary = wikiResult

            state = .finished
        } catch {
            state = .error(error)
        }
    }
}
