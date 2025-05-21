//
//  HeroErrorView.swift
//  CineNow
//
//  Created by Rishal Bazim on 21/05/25.
//

import SwiftUI

struct HeroErrorView: View {
    let retryAction: () -> Void

    var body: some View {
        VStack {
            ContentUnavailableView {
                Label("Unable to Connect", systemImage: "wifi.exclamationmark")
            } description: {
                Text("Please check your internet connection and try again.")
            } actions: {
                Button(action: retryAction) {
                    Label("Retry", systemImage: "arrow.clockwise")
                        .font(.headline)
                        .foregroundStyle(.primary)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 600)
    }
}

#Preview {
    HeroErrorView(retryAction: {})
}
