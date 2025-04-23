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

    func fetchPopularMovies() async throws -> [Movie] {
        // Step 1: Construct the base URL
        guard let url = URL(string: "\(Constants.API.baseURL)/movie/popular") else {
            throw TMDBError.invalidURL // Throw error if URL is invalid
        }
        
        // Step 2: Add query parameters (language in this case)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: Constants.API.language)
        ]
        let localComponents = components
        components?.queryItems = (localComponents?.queryItems ?? []) + queryItems
        guard let finalURL = components?.url else {
            throw TMDBError.invalidURL // Throw error if final URL is malformed
        }

        // Step 3: Create the URLRequest with necessary headers
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.API.key)"
        ]
        
        // Step 4: Fetch data using URLSession
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Step 5: Validate the response
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw TMDBError.invalidResponse // Throw error if response code is not 2xx
            }

            // Step 6: Decode the data into the MovieResponse model
            do {
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                return movieResponse.results // Return the movie results
            } catch {
                throw TMDBError.decodingError // Throw error if decoding fails
            }
        } catch {
            throw TMDBError.unknown(error) // Catch any other errors
        }
    }

}
