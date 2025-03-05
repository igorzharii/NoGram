//
//  GradientLoadingCircleView.swift
//  NoGram
//

import SwiftUI

struct ShimmerCircleView: View {
    @State private var phase: CGFloat = -1

    var body: some View {
        Circle()
            .fill(Color.gray.opacity(0.3))
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(0.0),
                        Color.white.opacity(0.6),
                        Color.white.opacity(0.0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .rotationEffect(Angle(degrees: 90))
                .offset(x: phase * 200)
            )
            .onAppear {
                withAnimation(
                    Animation.linear(duration: 1)
                        .repeatForever(autoreverses: false)
                ) {
                    phase = 1
                }
            }
            .clipShape(Circle())
    }
}

#Preview {
    ShimmerCircleView()
        .frame(width: 100, height: 100)
}
