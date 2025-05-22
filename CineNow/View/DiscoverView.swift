//
//  DiscoverView.swift
//  CineNow
//
//  Created by Rishal Bazim on 16/05/25.
//

import SwiftUI

struct DiscoverView: View {
    let endpoint: String
    let title: String
    @State var viewModel: DiscoverViewModel

    init(endpoint: String, title: String) {
        self.endpoint = endpoint
        self.title = title
        _viewModel = State(
            wrappedValue: DiscoverViewModel(endpoint: endpoint)
        )
    }
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack {
                Text(title)
                    .font(.title2.bold())
                    .lineLimit(1)
                Image(systemName: "chevron.right")
                    .font(.title)
                    .foregroundStyle(.secondary)
                Spacer()
            }.padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    LazyHStack(spacing: 15) {
                        ForEach(viewModel.movies.indices, id: \.self) { index in
                            if let movie = viewModel.movies[safe: index],
                                let posterPath = movie.poster_path
                            {
                                DiscoverMovieCard(
                                    imageUrl:
                                        "\(Constants.API.imageBaseUrl)/w500\(posterPath)"
                                )
                            }
                        }
                    }.padding(.horizontal)
                }
            }.onAppear {
                Task {
                    await viewModel.fetchDiscoverMovies()
                }
            }
        }.frame(height: 350)
    }
}

#Preview {
    DiscoverView(endpoint: "/movie/top_rated", title: "Discover Top Rated")
}
