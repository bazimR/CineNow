//
//  ContentView.swift
//  CineNow
//
//  Created by Rishal Bazim on 23/04/25.
//

import SwiftUI

struct ContentView: View {
    @State private var movielist: [Movie] = []
    var body: some View {
        HomeView().colorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
