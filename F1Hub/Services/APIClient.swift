//
//  APIClient.swift
//  F1Hub
//
//  Created by Marcos Morales on 11/04/2025.
//

import Foundation
import Alamofire

// MARK: - API Error
enum APIError: Error, LocalizedError {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
    case serverError(statusCode: Int)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL provided."
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid response from server."
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .serverError(let statusCode):
            return "Server error with status code: \(statusCode)"
        }
    }
}

// MARK: - API Client
class APIClient {
    static let shared = APIClient()
    private let session: Session

    private init() {
        session = Session.default
    }

    func request<T: Decodable>(
        _ url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil
    ) async throws -> T {
        guard let url = URL(string: url) else {
            throw APIError.invalidURL
        }

        return try await withCheckedThrowingContinuation { continuation in
            session.request(
                url,
                method: method,
                parameters: parameters,
                encoding: encoding,
                headers: headers
            ).validate { request, response, data in
                guard (200...299).contains(response.statusCode) else {
                    return .failure(APIError.serverError(statusCode: response.statusCode))
                }
                return .success(())
            }.responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    if let underlyingError = error.underlyingError {
                        continuation.resume(throwing: APIError.networkError(underlyingError))
                    } else if response.data == nil {
                        continuation.resume(throwing: APIError.invalidResponse)
                    } else {
                        continuation.resume(throwing: APIError.decodingError(error))
                    }
                }
            }
        }
    }
}
