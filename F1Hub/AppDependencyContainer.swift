//
//  AppDependencyContainer.swift
//  F1Hub
//
//  Created by Marcos Morales on 30/10/2025.
//

final class AppDependencyContainer {
    static let shared = AppDependencyContainer()

    private init() {}

    // MARK: – Services that will be swapped in UI-tests

    private(set) var f1APIService: F1APIServiceProtocol = F1APIService()
    private(set) var wikipediaAPIService: WikipediaAPIServiceProtocol = WikipediaAPIService()

    func useMockServices() {
        let mockF1Service = MockF1APIService()
        let mockWikipediaAPIService = MockWikipediaAPIService()

        mockF1Service.fetchCurrentDriversHandler = { Driver.mockDrivers() }

        mockF1Service.fetchDriverDetailHandler = { driverId in
            guard let driver = Driver.mockDrivers().first(where: { $0.id == driverId }) else {
                throw F1APIError.driverNotFound
            }
            return driver
        }

        mockF1Service.fetchCurrentRacesHandler = { Race.mockRaces() }

        mockF1Service.fetchCurrentDriversStandingsHandler = { StandingsEntry.mockDriversStandings() }
        mockF1Service.fetchCurrentTeamsStandingsHandler = { StandingsEntry.mockTeamsStandings() }

        mockF1Service.fetchTeamDetailHandler = { teamId in
            guard let team = Team.mockTeams().first(where: { $0.id == teamId }) else {
                throw F1APIError.teamNotFound
            }
            return team
        }

        mockWikipediaAPIService.fetchSummaryHandler = { url in
            guard let title = MockWikipediaAPIService.extractTitle(from: url) else {
                throw APIError.invalidURL
            }

            switch title {
            case "Max_Verstappen":
                return Driver.mockVerstappenWikipedia
            case "Red_Bull_Racing":
                return Team.mockRedBullWikipedia
            default:
                throw APIError.invalidURL
            }
        }

        f1APIService = mockF1Service
        wikipediaAPIService = mockWikipediaAPIService
    }
}
