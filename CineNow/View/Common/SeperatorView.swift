//
//  SeperatorView.swift
//  CineNow
//
//  Created by Rishal Bazim on 23/05/25.
//

import SwiftUI

struct SeperatorView: View {
    var body: some View {
        Rectangle().frame(height: 1).foregroundStyle(.primary.opacity(0.2))
            .padding(.vertical, 4)
    }
}

#Preview {
    SeperatorView()
}
