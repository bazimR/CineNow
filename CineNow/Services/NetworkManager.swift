//
//  NetworkManager.swift
//  CineNow
//
//  Created by Rishal Bazim on 23/04/25.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()

    func fetch<T: Decodable>(url: URLRequest, type: T.Type) async throws -> T {
        let (data, _) = try await URLSession.shared.data(for: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
