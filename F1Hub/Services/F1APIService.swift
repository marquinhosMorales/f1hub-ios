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

    var errorDescription: String? {
        switch self {
        case .driverNotFound:
            return "Driver not found."
        }
    }
}

struct F1APIService {
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
}
