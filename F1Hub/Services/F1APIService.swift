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
}
