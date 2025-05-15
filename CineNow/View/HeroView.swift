//
//  HeroView.swift
//  CineNow
//
//  Created by Rishal Bazim on 25/04/25.
//

import SwiftUI

struct HeroView: View {
    let array: [URL?] = [

        URL(
            string:
                "https://upload.wikimedia.org/wikipedia/en/b/bc/Interstellar_film_poster.jpg"
        ),

        URL(
            string:
                "https://upload.wikimedia.org/wikipedia/en/0/0d/Avengers_Endgame_poster.jpg"
        ),
        URL(
            string:
                "https://upload.wikimedia.org/wikipedia/en/f/fc/Fight_Club_poster.jpg"
        ),
    ]

    @State private var movies: [Movie] = [Movie]()
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 0) {
                ForEach(0..<movies.count, id: \.self) { Index in
                    let movie = movies[Index]
                    let url = URL(
                        string: "\(Constants.API.imageBaseUrl)/w500\(movie.poster_path)"
                    )
                    VStack {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 600, height: 600)
                                    .background(Color.gray.opacity(0.1))
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 20)
                                    )
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(
                                        width: UIScreen.main.bounds.width,
                                        height: 600
                                    ).clipped()
                            case .failure(_):
                                // When there's an error
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.gray)
                                    .background(Color.red.opacity(0.2))
                                    .cornerRadius(12)

                            @unknown default:
                                VStack {
                                    Text("Unknown error")
                                }
                            }
                        }
                    }.containerRelativeFrame(
                        .horizontal
                    )
                }
            }.onAppear {
                Task {
                    do {
                        movies = try await TMDBService.shared.fetchPopularMovies()
                        print("success")
                        print(movies[0].poster_path)
                    } catch {
                        print("Failed to fetch movies: \(error)")
                    }
                }
            }
        }.scrollTargetBehavior(.paging)
    }
}

#Preview {
    HeroView()
}
