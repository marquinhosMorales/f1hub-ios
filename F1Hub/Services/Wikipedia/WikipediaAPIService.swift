//
//  WikipediaAPIService.swift
//  F1Hub
//
//  Created by Marcos Morales on 01/10/2025.
//

import Foundation

// MARK: - WikipediaAPI Protocols for Dependency Injection

protocol WikipediaAPIServiceProtocol {
    func fetchSummary(from url: String) async throws -> WikipediaSummary
}

struct WikipediaAPIService: WikipediaAPIServiceProtocol {
    private let client = APIClient.shared
    private let baseURL = "https://en.wikipedia.org/api/rest_v1/page/summary"

    // Fetch Wikipedia summary by title
    func fetchSummary(for title: String) async throws -> WikipediaSummary {
        let encodedTitle = title.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? title
        let url = "\(baseURL)/\(encodedTitle)"
        return try await client.request(url)
    }

    // Fetch Wikipedia summary directly from a full Wikipedia URL
    func fetchSummary(from url: String) async throws -> WikipediaSummary {
        guard let title = extractTitle(from: url) else {
            throw APIError.invalidURL
        }
        return try await fetchSummary(for: title)
    }

    // Helper: Extracts the page title from a Wikipedia URL
    private func extractTitle(from url: String) -> String? {
        guard let components = URL(string: url)?.pathComponents else { return nil }
        guard let index = components.firstIndex(of: "wiki"), index + 1 < components.count else { return nil }
        return components[index + 1]
    }
}
