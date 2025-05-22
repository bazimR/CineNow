//
//  TMDBService.swift
//  CineNow
//
//  Created by Rishal Bazim on 23/04/25.
//

import Foundation

enum TMDBError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .invalidResponse:
            return "The server response was invalid."
        case .decodingError:
            return "Failed to decode the response from the server."
        case .unknown(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
}

struct TMDBService {
    static let shared = TMDBService()

    func fetchMovies(from endpoint: String) async throws -> [Movie] {
        guard let url = URL(string: "\(Constants.API.baseURL)\(endpoint)")
        else {
            throw TMDBError.invalidURL
        }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            URLQueryItem(name: "language", value: Constants.API.language)
        ]
        guard let finalURL = components?.url else {
            throw TMDBError.invalidURL
        }

        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.API.key)",
        ]

        do {
            let movieResponse: PopularMoviesResponse =
                try await NetworkManager.shared
                .fetch(url: request, type: PopularMoviesResponse.self)
            return movieResponse.results
        } catch let error as NetworkError {
            throw TMDBError.unknown(error)
        } catch {
            throw TMDBError.unknown(error)
        }
    }

}
