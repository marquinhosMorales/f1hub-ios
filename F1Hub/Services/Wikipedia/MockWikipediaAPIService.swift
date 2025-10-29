//
//  MockWikipediaAPIService.swift
//  F1Hub
//
//  Created by Marcos Morales on 24/10/2025.
//

class MockWikipediaAPIService: WikipediaAPIServiceProtocol {
    var fetchSummaryHandler: ((String) async throws -> WikipediaSummary)?

    func fetchSummary(from url: String) async throws -> WikipediaSummary {
        if let handler = fetchSummaryHandler {
            return try await handler(url)
        }
        throw APIError.invalidURL
    }
}
