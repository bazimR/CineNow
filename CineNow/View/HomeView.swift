//
//  HomeView.swift
//  CineNow
//
//  Created by Rishal Bazim on 25/04/25.
//

import SwiftUI

extension View {
    func navigationBarTitleMainColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)

        // Create a shadow
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.2)
        shadow.shadowOffset = CGSize(width: 2, height: 2)
        shadow.shadowBlurRadius = 3
        UINavigationBar
            .appearance().largeTitleTextAttributes = [
                .foregroundColor: uiColor,
                .shadow: shadow,
            ]
        return self
    }
    func navigationBarTitleInlineColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar
            .appearance().titleTextAttributes = [.foregroundColor: uiColor]

        return self
    }
}

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                HeroView()
                VStack(spacing: 10) {
                    DiscoverView(
                        endpoint: "/movie/top_rated",
                        title: "Top rated movies"
                    )
                    DiscoverView(
                        endpoint: "/movie/now_playing",
                        title: "Now playing movies"
                    )
                    DiscoverView(
                        endpoint: "/movie/upcoming",
                        title: "Upcoming movies"
                    )
                }.padding(.top, 10).padding(.bottom, 40)
            }.ignoresSafeArea().navigationTitle("Home").toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {

                    } label: {
                        Label("settings", systemImage: "gear")
                    }

                }
            }
        }.navigationBarTitleMainColor(.white)
    }
}

#Preview {
    HomeView().colorScheme(.dark)
}
