//
//  DiscoverViewModel.swift
//  CineNow
//
//  Created by Rishal Bazim on 21/05/25.
//

import Foundation
import SwiftUI

@Observable
class DiscoverViewModel {
    let endpoint: String
    var movies: [Movie] = []
    var errorFetching: Bool = false
    var isLoading: Bool = false

    func fetchDiscoverMovies() async {
        isLoading = true
        do {
            movies = try await TMDBService.shared.fetchMovies(
                from: endpoint
            )
            errorFetching = false

        } catch {
            errorFetching = true
            print(error.localizedDescription)
        }
        isLoading = false
    }

    init(
        endpoint: String,
    ) {
        self.endpoint = endpoint
    }
}
