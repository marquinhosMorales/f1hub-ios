//
//  APIClient.swift
//  F1Hub
//
//  Created by Marcos Morales on 11/04/2025.
//

import Alamofire
import Foundation

// MARK: - API Error

enum APIError: Error, LocalizedError, Equatable {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
    case serverError(statusCode: Int)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL provided."
        case let .networkError(error):
            return "Network error: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid response from server."
        case let .decodingError(error):
            return "Failed to decode response: \(error.localizedDescription)"
        case let .serverError(statusCode):
            return "Server error with status code: \(statusCode)"
        }
    }

    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.invalidResponse, .invalidResponse):
            return true
        case let (.serverError(lhsStatus), .serverError(rhsStatus)):
            return lhsStatus == rhsStatus
        case let (.networkError(lhsError), .networkError(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case let (.decodingError(lhsError), .decodingError(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
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
            ).validate { _, response, _ in
                guard (200 ... 299).contains(response.statusCode) else {
                    return .failure(APIError.serverError(statusCode: response.statusCode))
                }
                return .success(())
            }.responseDecodable(of: T.self) { response in
                switch response.result {
                case let .success(value):
                    continuation.resume(returning: value)
                case let .failure(error):
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
