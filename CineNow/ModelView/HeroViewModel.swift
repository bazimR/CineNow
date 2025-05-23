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
    var isLoading: Bool = false

    func fetchPopularMovies() async {
        isLoading = true
        do {
            movies = try await TMDBService.shared.fetchMovies(from: "/movie/popular")
            errorFetching = false

        } catch {
            errorFetching = true
            print(error.localizedDescription)
        }
        isLoading = false
    }
}
