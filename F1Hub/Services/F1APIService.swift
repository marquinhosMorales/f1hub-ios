//
//  F1APIService.swift
//  F1Hub
//
//  Created by Marcos Morales on 11/04/2025.
//

struct F1APIService {
    private let client = APIClient.shared
    private let baseURL = "https://f1api.dev"

    func fetchCurrentDrivers() async throws -> [Driver] {
        let url = "\(baseURL)/api/current/drivers"
        let response: CurrentDriversResponse = try await client.request(url)
        return response.drivers
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
