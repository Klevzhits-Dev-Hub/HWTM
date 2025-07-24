//
//  HomeContentView.swift
//  HWTM
//
//  Created by Михаил Болгар on 17.07.2025.
//

import SwiftUI

struct HomeContentView: View {
    @ObservedObject var vm: HomeVM

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    GradientBackground()

                    VStack(alignment: .center, spacing: .zero) {
                        logoView(geometry: geometry)
                        labelsView(geometry: geometry)
                        buttonsView(geometry: geometry)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        vm.onSupportButtonTapped()
//                        vm.showModal = true
                    }) {
                        Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white)
                            .padding()
                    }
                    .fullScreenCover(isPresented: $vm.showModal) { SupportContentView()
                    }
                }
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
        VStack(spacing: 8) {
            switch vm.gameState {
            case .notStarted, .inProgress:
                Text("Who Wants\nto be a Millioner")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)

                if vm.hasPlayed == true {
                    Text("All-time Best Score")
                        .foregroundColor(.gray)
                }

            case .gameOver(let score):
                Text("Game over!")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)

                HStack(alignment: .center, spacing: .zero) {
                    Text("$\(score)")
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
        }
        .frame(height: geometry.size.height * 0.2)
    }

    private func buttonsView(geometry: GeometryProxy) -> some View {
        VStack(spacing: 14) {

            switch vm.gameState {
            case .notStarted:
                SystemButton(label: "New game", type: .active) {
                    // push game screen
                }

            case .inProgress:
                SystemButton(label: "Continue", type: .active) {
                    // push saved game screen
                }
                SystemButton(label: "New game", type: .neutral) {
                    // push a new game screen
                }

            case .gameOver(_):
                SystemButton(label: "New game", type: .active) {
                    // push game screen
                }
                SystemButton(label: "Main screen", type: .neutral) {
                    // push game screen
                }
            }
        }
    }
}

//#Preview {
//    HomeContentView(vm: HomeVM())
//}
