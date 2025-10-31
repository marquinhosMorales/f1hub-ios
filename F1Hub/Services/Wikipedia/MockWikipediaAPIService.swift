//
//  MockWikipediaAPIService.swift
//  F1Hub
//
//  Created by Marcos Morales on 24/10/2025.
//

import Foundation

class MockWikipediaAPIService: WikipediaAPIServiceProtocol {
    var fetchSummaryHandler: ((String) async throws -> WikipediaSummary)?

    func fetchSummary(from url: String) async throws -> WikipediaSummary {
        if let handler = fetchSummaryHandler {
            return try await handler(url)
        }
        throw APIError.invalidURL
    }

    // Helper: Extracts the page title from a Wikipedia URL
    static func extractTitle(from url: String) -> String? {
        guard let components = URL(string: url)?.pathComponents else { return nil }
        guard let index = components.firstIndex(of: "wiki"), index + 1 < components.count else { return nil }
        return components[index + 1]
    }
}
