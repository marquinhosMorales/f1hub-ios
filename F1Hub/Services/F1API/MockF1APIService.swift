//
//  MockF1APIService.swift
//  F1Hub
//
//  Created by Marcos Morales on 24/10/2025.
//

class MockF1APIService: F1APIServiceProtocol {
    var fetchCurrentDriversHandler: (() async throws -> [Driver])?
    var fetchDriverDetailHandler: ((String) async throws -> Driver)?
    var fetchCurrentRacesHandler: (() async throws -> [Race])?
    var fetchCurrentDriversStandingsHandler: (() async throws -> [StandingsEntry])?
    var fetchCurrentTeamsStandingsHandler: (() async throws -> [StandingsEntry])?
    var fetchTeamDetailHandler: ((String) async throws -> Team)?

    func fetchCurrentDrivers() async throws -> [Driver] {
        if let handler = fetchCurrentDriversHandler {
            return try await handler()
        }
        throw APIError.invalidResponse
    }

    func fetchDriverDetail(driverId: String) async throws -> Driver {
        if let handler = fetchDriverDetailHandler {
            return try await handler(driverId)
        }
        throw F1APIError.driverNotFound
    }

    func fetchCurrentRaces() async throws -> [Race] {
        if let handler = fetchCurrentRacesHandler {
            return try await handler()
        }
        throw APIError.invalidResponse
    }

    func fetchCurrentDriversStandings() async throws -> [StandingsEntry] {
        if let handler = fetchCurrentDriversStandingsHandler {
            return try await handler()
        }
        throw APIError.invalidResponse
    }

    func fetchCurrentTeamsStandings() async throws -> [StandingsEntry] {
        if let handler = fetchCurrentTeamsStandingsHandler {
            return try await handler()
        }
        throw APIError.invalidResponse
    }

    func fetchTeamDetail(teamId: String) async throws -> Team {
        if let handler = fetchTeamDetailHandler {
            return try await handler(teamId)
        }
        throw F1APIError.teamNotFound
    }
}
