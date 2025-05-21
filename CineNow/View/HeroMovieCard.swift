//
//  HeroMovieCard.swift
//  CineNow
//
//  Created by Rishal Bazim on 21/05/25.
//

import SwiftUI

struct HeroMovieCard: View {
    let movie: Movie
    let imageUrl: String

    var body: some View {
        VStack {
            ZStack {
                AsyncImage(url: URL(string: imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        SkeletonView()
                            .frame(
                                width: UIScreen.main.bounds.width,
                                height: 600
                            )
                            .cornerRadius(
                                30,
                                corner: [.bottomLeft,.bottomRight]
                            )
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: UIScreen.main.bounds.width,
                                height: 600
                            )
                            .clipped()
                            .cornerRadius(
                                30,
                                corner: [.bottomLeft,.bottomRight]
                            )
                    case .failure(_):
                        Image(systemName: "photo.badge.exclamationmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.secondary)
                            .frame(
                                width: UIScreen.main.bounds.width,
                                height: 600
                            )
                            .background(Color.gray.opacity(0.2))
                    @unknown default:
                        Text("Unknown error")
                    }
                }

                // Overlay Content
                VStack {
                    Spacer()
                    VStack(alignment: .center, spacing: 15) {
                        Text(movie.title)
                            .font(.largeTitle.bold())
                            .foregroundStyle(.primary)
                            .padding(.horizontal, 15)
                            .multilineTextAlignment(.center)

                        Text(movie.overview)
                            .font(.caption)
                            .foregroundStyle(.primary.opacity(0.6))
                            .padding(.horizontal, 15)
                            .lineLimit(3)
                            .multilineTextAlignment(.center)

                        HStack {
                            Button("More info", systemImage: "info.circle") {}
                                .foregroundStyle(.black)
                                .buttonStyle(.borderedProminent)
                                .tint(.white)
                                .font(.headline)
                                .buttonBorderShape(.capsule)

                            Button(action: {}) {
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
                    .frame(
                        width: UIScreen.main.bounds.width - 20
                    )
                    .padding(.vertical, 15)
                    .background(Material.ultraThin)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .shadow(radius: 10)
                    .padding()
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 600)
        }
        .containerRelativeFrame(.horizontal)
    }
}

#Preview {
    HeroMovieCard(
        movie: .init(
            id: 950387,
            title: "A Minecraft Movie",
            overview:
                "Four misfits find themselves struggling with ordinary problems when they are suddenly pulled through a mysterious portal into the Overworld: a bizarre, cubic wonderland that thrives on imagination. To get back home, they'll have to master this world while embarking on a magical quest with an unexpected, expert crafter, Steve.",
            release_date: "2025-03-31",
            poster_path: "/yFHHfHcUgGAxziP1C3lLt0q2T4s.jpg",
            backdrop_path: "/yFHHfHcUgGAxziP1C3lLt0q2T4s.jpg",
            genre_ids: [1, 2, 4],
            vote_average: 10.0,
            vote_count: 2
        ),
        imageUrl: "\(Constants.API.imageBaseUrl)/original/yFHHfHcUgGAxziP1C3lLt0q2T4s.jpg"
    )
}
