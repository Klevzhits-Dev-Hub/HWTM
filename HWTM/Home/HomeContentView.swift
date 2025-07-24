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
            Text("Who Wants\nto be a Millioner")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)

            if vm.hasPlayed == true {
                Text("All-time Best Score")
                    .foregroundColor(.gray)
            }
        }
        .frame(height: geometry.size.height * 0.2)
    }

    private func buttonsView(geometry: GeometryProxy) -> some View {
        VStack(spacing: 16) {
            if vm.gameState == .inProgress {
                SystemButton(label: "Continue", type: .active) {
                    // action
                }
            }

            // переделать в SystemButton
            Button(action: {
                vm.onStartButtonTapped()
            }) {
                Text("New Game")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, minHeight: 56)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.yellow, Color.orange]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .padding(.horizontal, 40)
                    .shadow(radius: 5)
            }
        }
        .frame(height: geometry.size.height * 0.2)
    }
}

#Preview {
    HomeContentView(vm: HomeVM())
}
