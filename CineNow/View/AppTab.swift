//
//  AppTab.swift
//  CineNow
//
//  Created by Rishal Bazim on 23/05/25.
//

import SwiftUI

enum TabMenu {
    case Movies, TV, Saved
}

struct AppTab: View {
    @State private var selectedTab: TabMenu = .Movies
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Movies", systemImage: "movieclapper", value: .Movies) {
                HomeView()
            }
            .badge(2)

            Tab("TV", systemImage: "tv", value: .TV) {
                VStack {
                    Text("hi")
                }
            }

            Tab(
                "Account",
                systemImage: "person.crop.circle.fill",
                value: .Saved
            ) {
                VStack {
                    Text("hi settings")
                }
            }
            .badge("!")
        }
    }
}

#Preview {
    AppTab()
}
