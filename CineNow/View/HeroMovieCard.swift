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
                            .frame(width: UIScreen.main.bounds.width, height: 600)
                            .cornerRadius(0)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: 600)
                            .clipped()
                    case .failure(_):
                        Image(systemName: "photo.badge.exclamationmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.secondary)
                            .frame(width: UIScreen.main.bounds.width, height: 600)
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
//    HeroMovieCard()
}
