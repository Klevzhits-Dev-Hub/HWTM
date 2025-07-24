//
//  GameOverContentView.swift
//  HWTM
//
//  Created by Михаил Болгар on 24.07.2025.
//

import SwiftUI

struct GameOverContentView: View {
    @ObservedObject var vm: GameOverVM

    var body: some View {
        ZStack {
            GradientBackground()
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    VStack(alignment: .center, spacing: .zero) {
                        logoView(geometry: geometry)
                        labelsView(geometry: geometry)
                    }

                    Spacer()
                    buttonsView(geometry: geometry)
                        .padding(.bottom, 1)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }

    private func logoView(geometry: GeometryProxy) -> some View {
        VStack {
            Spacer()
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(height: geometry.size.height * 0.4)
                .clipShape(Circle())
                .shadow(radius: 10)
            Spacer()
        }
        .frame(height: geometry.size.height * 0.4)
    }

    private func labelsView(geometry: GeometryProxy) -> some View {
        VStack(spacing: .zero) {
            Text("\(vm.gameState.mainTitle)")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)

            if vm.gameState == .gameOver {
                Text("Level \(vm.level)")
                    .foregroundColor(.gray)
                    .padding(.top, 18)
            }

            HStack(alignment: .center, spacing: .zero) {
                Text("$\(vm.prize)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Image("coin")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            }
        }
        .frame(height: geometry.size.height * 0.2)
    }

    private func buttonsView(geometry: GeometryProxy) -> some View {
        VStack(spacing: 14) {

            SystemButton(label: "\(vm.gameState.continueButtonTitle)", type: .active) {
                // push saved game screen
            }
            SystemButton(label: "Maybe next time", type: .neutral) {
                // push a new game screen
            }
        }
//        .padding(.top, 32)
    }
}

#Preview {
    GameOverContentView(vm: GameOverVM(
        initialState: .gameWon,
        level: 5,
        prize: 5000)
    )
}
