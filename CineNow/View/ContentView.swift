//
//  ContentView.swift
//  CineNow
//
//  Created by Rishal Bazim on 23/04/25.
//

import SwiftUI

struct ContentView: View {
    @State private var movielist: [Movie] = []
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("\(movielist.count)")
            if !movielist.isEmpty {
                AsyncImage(
                    url: URL(
                        string: Constants.API.imageBaseUrl
                        + "/original\(movielist[1].backdrop_path)"
                    )
                )
            }
            Button("fetch movies") {
                Task {
                    await fetchPopularMovies()
                }
            }
        }
        .padding()
    }

    func fetchPopularMovies() async {
        do {
            let movies = try await TMDBService.shared.fetchPopularMovies()
            movielist = movies
            print(movies)
        } catch {
            print("failed to fetch \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
