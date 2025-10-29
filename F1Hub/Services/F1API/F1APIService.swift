//
//  F1APIService.swift
//  F1Hub
//
//  Created by Marcos Morales on 11/04/2025.
//

import Foundation

// MARK: - F1API Error

enum F1APIError: Error, LocalizedError {
    case driverNotFound
    case teamNotFound

    var errorDescription: String? {
        switch self {
        case .driverNotFound:
            return "Driver not found."
        case .teamNotFound:
            return "Team not found."
        }
    }
}

// MARK: - F1API Protocols for Dependency Injection

protocol F1APIServiceProtocol {
    func fetchCurrentDrivers() async throws -> [Driver]
    func fetchDriverDetail(driverId: String) async throws -> Driver
    func fetchCurrentRaces() async throws -> [Race]
    func fetchCurrentDriversStandings() async throws -> [StandingsEntry]
    func fetchCurrentTeamsStandings() async throws -> [StandingsEntry]
    func fetchTeamDetail(teamId: String) async throws -> Team
}

struct F1APIService: F1APIServiceProtocol {
    private let client = APIClient.shared
    private let baseURL = "https://f1api.dev"

    func fetchCurrentDrivers() async throws -> [Driver] {
        let url = "\(baseURL)/api/current/drivers"
        let response: CurrentDriversResponse = try await client.request(url)
        return response.drivers
    }

    func fetchDriverDetail(driverId: String) async throws -> Driver {
        let url = "\(baseURL)/api/drivers/\(driverId)"
        let response: DriverDetailResponse = try await client.request(url)
        guard let driver = response.drivers.first else {
            throw F1APIError.driverNotFound
        }
        return driver
    }

    func fetchCurrentRaces() async throws -> [Race] {
        let url = "\(baseURL)/api/current"
        let response: CurrentRacesResponse = try await client.request(url)
        return response.races
    }

    func fetchCurrentDriversStandings() async throws -> [StandingsEntry] {
        let url = "\(baseURL)/api/current/drivers-championship"
        let response: CurrentDriversStandingsResponse = try await client.request(url)
        return response.driversStandings
    }

    func fetchCurrentTeamsStandings() async throws -> [StandingsEntry] {
        let url = "\(baseURL)/api/current/constructors-championship"
        let response: CurrentTeamsStandingsResponse = try await client.request(url)
        return response.teamsStandings
    }

    func fetchTeamDetail(teamId: String) async throws -> Team {
        let url = "\(baseURL)/api/teams/\(teamId)"
        let response: TeamDetailResponse = try await client.request(url)
        guard let team = response.teams.first else {
            throw F1APIError.teamNotFound
        }
        return team
    }
}
