//
//  SplashView.swift
//  HWTM
//
//  Created by Игорь Клевжиц on 27.07.2025.
//

import SwiftUI

struct SplashView: View {
    @State private var appear = false
    @State private var scale = 0.8
    var body: some View {
        GeometryReader { geometry in /// different screen sizes
            ZStack {
                GradientBackground()
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(scale)
                    .onAppear {
                        withAnimation(.easeOut(duration: 1)) {
                            scale = 1.0
                        }
                    }
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .position(x: geometry.size.width / 2, y: geometry.size.height * 0.8)
            }
            .onAppear() {
                AnswersMusic.shared.playOST()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

#Preview {
    SplashView()
}
