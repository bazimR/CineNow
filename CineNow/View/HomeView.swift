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
    HomeView()
}
