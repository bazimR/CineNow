//
//  HeroView.swift
//  CineNow
//
//  Created by Rishal Bazim on 25/04/25.
//

import SwiftUI

struct HeroView: View {
    @State var viewModel: HeroViewModel = HeroViewModel()
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            Group {
                if !viewModel.errorFetching {
                    LazyHStack(spacing: 0) {
                        ForEach(0..<viewModel.movies.count, id: \.self) {
                            Index in
                            let movie = viewModel.movies[Index]
                            let url = URL(
                                string:
                                    "\(Constants.API.imageBaseUrl)/original\(movie.poster_path)"
                            )
                            VStack {
                                ZStack {
                                    AsyncImage(url: url) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView().progressViewStyle(
                                                .circular
                                            )
                                            .frame(
                                                width: UIScreen.main.bounds
                                                    .width,
                                                height: 600
                                            )
                                            .scaledToFit()
                                            .background(Color.gray.opacity(0.2))

                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(
                                                    width: UIScreen.main.bounds
                                                        .width,
                                                    height: 600
                                                ).clipped()
                                        case .failure(_):
                                            VStack {
                                                Image(
                                                    systemName:
                                                        "exclamationmark.triangle"
                                                )
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 100, height: 100)
                                                .foregroundColor(.red)
                                            }
                                            .frame(
                                                width: UIScreen.main.bounds
                                                    .width,
                                                height: 600
                                            )
                                            .background(Color.red.opacity(0.3))
                                            .cornerRadius(12)
                                        @unknown default:
                                            VStack {
                                                Text("Unknown error")
                                            }
                                        }
                                    }
                                    VStack {
                                        Spacer()
                                        VStack(alignment: .center, spacing: 15)
                                        {
                                            Text(movie.title)
                                                .font(.largeTitle.bold())
                                                .foregroundStyle(.primary)
                                                .padding(.horizontal, 15)
                                                .padding(.top, 5)
                                                .multilineTextAlignment(.center)
                                            Text(movie.overview)
                                                .font(.caption)
                                                .foregroundStyle(
                                                    .primary.opacity(0.6)
                                                )
                                                .padding(.horizontal, 15)
                                                .lineLimit(3)
                                                .truncationMode(.tail)
                                                .multilineTextAlignment(.center)
                                            HStack {
                                                Button(
                                                    "More info",
                                                    systemImage: "info.circle"
                                                ) {}
                                                .foregroundStyle(.black)
                                                .buttonStyle(.borderedProminent)
                                                .tint(.white)
                                                .font(.headline)
                                                .buttonBorderShape(.capsule)

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
                                        .background(Material.ultraThin)
                                        .clipShape(.rect(cornerRadius: 25))
                                        .shadow(radius: 10)
                                        .padding()
                                    }
                                }
                                .frame(
                                    width: UIScreen.main.bounds.width,
                                    height: 600
                                )
                            }
                            .containerRelativeFrame(.horizontal)
                        }
                    }
                } else {
                    VStack {
                        ContentUnavailableView {
                            Label(
                                "Unable to Connect",
                                systemImage: "wifi.exclamationmark"
                            )
                        } description: {
                            Text(
                                "Please check your internet connection and try again."
                            )
                        }
                        Button {
                            Task {
                                await viewModel.fetchPopularMovies()
                            }
                        } label: {
                            Label("Retry", systemImage: "arrow.clockwise")
                                .font(.headline)
                        }.buttonBorderShape(.capsule)
                            .buttonStyle(.borderedProminent)
                            .tint(.blue).controlSize(.large)
                    }
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: 600
                    )
                }
            }
        }
        .scrollTargetBehavior(.paging)  // ✅ Applied here
        .onAppear {
            Task {
                await viewModel.fetchPopularMovies()
            }
        }
    }
}

#Preview {
    HeroView()
}
