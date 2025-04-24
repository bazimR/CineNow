//
//  NetworkManager.swift
//  CineNow
//
//  Created by Rishal Bazim on 23/04/25.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidResponse
    case decodingFailed
    case serverError(statusCode: Int)
    case unknown(
        Error
    )

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "The server response was not valid."
        case .decodingFailed:
            return "Failed to decode the data."
        case .serverError(let statusCode):
            return "Server responded with status code \(statusCode)."
        case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()

    func fetch<T: Decodable>(url: URLRequest, type: T.Type) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(for: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                throw
                    NetworkError
                    .serverError(statusCode: httpResponse.statusCode)
            }

            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingFailed
            }
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}
