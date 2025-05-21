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
            if viewModel.errorFetching {
                HeroErrorView(retryAction: {
                    Task { await viewModel.fetchPopularMovies() }
                })
            } else {
                LazyHStack(spacing: 0) {
                    ForEach(viewModel.movies.indices, id: \.self) { index in
                        if let movie = viewModel.movies[safe: index],
                            let posterPath = movie.poster_path
                        {
                            HeroMovieCard(
                                movie: movie,
                                imageUrl:
                                    "\(Constants.API.imageBaseUrl)/original\(posterPath)"
                            )
                        }
                    }
                }
            }
        }.frame(
            width: UIScreen.main.bounds.width,
            height: 600
        )
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
