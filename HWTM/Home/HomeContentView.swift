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

        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.black]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // обернуть в группы стеков
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Button(action: {
                            vm.onSupportButtonTapped()
                        }) {
                            Image(systemName: "questionmark.circle.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                    .frame(height: geometry.size.height * 0.1)

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

                    // 3. Лейблы
                    VStack(spacing: 8) {
                        Text("Who Wants\nto be a Millioner")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)

                        if vm.gameState == .started {
                            Text("All-time Best Score")
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(height: geometry.size.height * 0.2)

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

                    Spacer(minLength: 0)
                }
            }
        }
    }
}

#Preview {
    HomeContentView(vm: HomeVM())
}
