import Foundation
import SwiftUI

struct SkeletonView: View {
    var cornerRadius: CGFloat = 0

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.white.opacity(0.4))
            .blinking(duration: 2)
    }
}

struct BlinkViewModifier: ViewModifier {
    let duration: Double
    @State private var blinking: Bool = false

    func body(content: Content) -> some View {
        content
            .opacity(blinking ? 0.1 : 0.4)
            .animation(
                .easeInOut(duration: duration).repeatForever(),
                value: blinking
            )
            .onAppear {
                // Animation will only start when blinking value changes
                blinking.toggle()
            }
    }
}

extension View {
    func blinking(duration: Double = 1) -> some View {
        modifier(BlinkViewModifier(duration: duration))
    }
}
