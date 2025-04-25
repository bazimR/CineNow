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
        UINavigationBar
            .appearance().largeTitleTextAttributes = [.foregroundColor: uiColor]
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
            }.ignoresSafeArea().navigationTitle("Home")
        }.navigationBarTitleMainColor(.white)
    }
}

#Preview {
    HomeView()
}
