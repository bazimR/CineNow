//
//  HeroView.swift
//  CineNow
//
//  Created by Rishal Bazim on 25/04/25.
//

import SwiftUI

struct HeroView: View {
    let url = URL(
        string:
            "https://as2.ftcdn.net/v2/jpg/02/12/52/91/1000_F_212529193_YRhcQCaJB9ugv5dFzqK25Uo9Ivm7B9Ca.jpg"
    )
    let url2 = URL(
        string:
            "https://as2.ftcdn.net/v2/jpg/03/77/77/97/1000_F_377779796_swIOhupa2uTGVGG50Gv8wIfvj9qWneMW.jpg"
    )
    var body: some View {
        VStack {
            AsyncImage(url: url2) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 300, height: 300)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(
                            maxWidth: .infinity,
                            minHeight: 700,
                            maxHeight: 800
                        )
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
        }
    }
}

#Preview {
    HeroView()
}
