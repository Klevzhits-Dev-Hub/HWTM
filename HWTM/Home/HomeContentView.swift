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

            VStack(spacing: 40) {

                HStack() {
                    Spacer()
                    Button(action: {
                        vm.onSupportButtonTapped()
                    })
                    {
                        Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white)
                            .padding()
                    }
                }

                Spacer()

                GeometryReader { geometry in
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipShape(Circle())
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                }

                Text("Who Wants\nto be a Millioner")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)

                if vm.gameState == .started {
                    Text("All-time Best score")
                        .foregroundColor(.gray)
                }

                Spacer()
                Spacer()

                Button(action: {
                    vm.onStartButtonTapped()
                }) {
                    Text("New Game")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: . infinity)
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

                Spacer()
            }
        }
    }
}

#Preview {
    HomeContentView(vm: HomeVM())
}
