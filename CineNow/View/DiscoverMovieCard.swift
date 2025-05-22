//
//  DiscoverMovieCard.swift
//  CineNow
//
//  Created by Rishal Bazim on 23/05/25.
//

import SwiftUI

struct DiscoverMovieCard: View {
    let imageUrl: String
    var body: some View {
        VStack {
            AsyncImage(
                url: URL(
                    string:
                        imageUrl
                )
            ) { phase in
                switch phase {
                case .empty:
                    SkeletonView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity
                        )
                case .failure(_):
                    Image(
                        systemName:
                            "photo.badge.exclamationmark"
                    )
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.secondary)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )
                    .background(Color.gray.opacity(0.2))
                @unknown default:
                    Text("unknown error")
                }
            }
        }
        .frame(width: 180, height: 280).background(
            Color.gray
        ).cornerRadius(
            20,
            corner: .allCorners
        )
        
    }
}

#Preview {
    DiscoverMovieCard(
        imageUrl:
            "\(Constants.API.imageBaseUrl)/original/yFHHfHcUgGAxziP1C3lLft0q2T4s.jpg"
    )
}
