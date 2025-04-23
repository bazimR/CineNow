//
//  ContentView.swift
//  CineNow
//
//  Created by Rishal Bazim on 23/04/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
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
            print(movies)
        } catch {
            print("failed to fetch \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
