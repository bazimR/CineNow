//
//  HeroViewModel.swift
//  CineNow
//
//  Created by Rishal Bazim on 16/05/25.
//

import Foundation
import SwiftUI

@Observable
class HeroViewModel {
    var movies: [Movie] = []
    var errorFetching: Bool = false
    func fetchPopularMovies() async {
        do {
            movies = try await TMDBService.shared.fetchPopularMovies()
        } catch {
            errorFetching = true
            print(
                "failed to fetch popular movies \(error.localizedDescription)"
            )
        }
    }
}
