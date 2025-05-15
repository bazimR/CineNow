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
                        string:
                            "\(Constants.API.imageBaseUrl)/original\(movie.poster_path)"
                    )
                    VStack {
                        ZStack {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView().progressViewStyle(.circular)
                                        .frame(
                                            width: UIScreen.main.bounds.width,
                                            height: 600
                                        )
                                        .scaledToFit()
                                        .background(Color.gray.opacity(0.2))

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
                                    VStack {
                                        Image(
                                            systemName:
                                                "exclamationmark.triangle"
                                        )
                                        .resizable()
                                        .scaledToFit()
                                        .frame(
                                            width: 200,
                                            height: 200
                                        )
                                        .foregroundColor(.red)

                                    }.frame(
                                        width: UIScreen.main.bounds.width,
                                        height: 600
                                    ).background(Color.red.opacity(0.3))
                                        .cornerRadius(12)
                                @unknown default:
                                    VStack {
                                        Text("Unknown error")
                                    }
                                }
                            }
                            VStack {
                                Spacer()
                                VStack(alignment: .center, spacing: 15) {
                                    Text(movie.title)
                                        .font(.largeTitle.bold())
                                        .foregroundStyle(.primary)
                                        .padding(.horizontal, 15)
                                        .padding(.top, 5)
                                        .multilineTextAlignment(.center)
                                    Text(movie.overview)
                                        .font(.caption)
                                        .foregroundStyle(.primary.opacity(0.6))
                                        .padding(.horizontal, 15)
                                        .lineLimit(3)
                                        .truncationMode(.tail)
                                        .multilineTextAlignment(.center)
                                    HStack {
                                        Button(
                                            "More info",
                                            systemImage: "info.circle"
                                        ) {

                                        }.foregroundStyle(.black)
                                            .buttonStyle(
                                                .borderedProminent
                                            )
                                            .tint(.white)
                                            .font(.headline)
                                            .buttonBorderShape(
                                                .capsule
                                            )
                                        Button {
                                            // Action here
                                        } label: {
                                            Image(systemName: "plus")
                                                .fontWeight(.bold)
                                        }
                                        .foregroundStyle(.black)
                                        .buttonStyle(.borderedProminent)
                                        .tint(.white.opacity(0.2))
                                        .buttonBorderShape(.circle)
                                        .controlSize(.large)
                                    }
                                }
                                .padding(5)
                                .padding(.vertical, 15)
                                .background(
                                    Material.ultraThin
                                )
                                .clipShape(
                                    .rect(cornerRadius: 25)
                                )
                                .shadow(radius: 10)
                                .padding()

                            }
                        }.frame(
                            width: UIScreen.main.bounds.width,
                            height: 600
                        )
                    }.containerRelativeFrame(
                        .horizontal
                    )
                }
            }.onAppear {
                Task {
                    do {
                        movies = try await TMDBService.shared
                            .fetchPopularMovies()
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
