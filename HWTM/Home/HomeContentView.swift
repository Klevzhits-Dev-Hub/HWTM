//
//  HomeContentView.swift
//  HWTM
//
//  Created by Михаил Болгар on 17.07.2025.
//

import SwiftUI

struct HomeContentView: View {
    @ObservedObject var vm: HomeVM
    @StateObject var gameViewModelNewGame: GameViewModel = GameViewModel(typeOfScreen: .newGame)
    @StateObject var gameViewModelSaved: GameViewModel = GameViewModel(typeOfScreen: .saved)
    @State private var isGoingToGameScreen = false

    var body: some View {
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
                        vm.showModal = true
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
            }
        }
        .frame(height: geometry.size.height * 0.2)
    }

    private func buttonsView(geometry: GeometryProxy) -> some View {
        VStack(spacing: 14) {

            switch vm.gameState {
            case .notStarted:
              navigationButtonToGame(lable: "New game", type: .active, viewModel: gameViewModelNewGame)
            case .inProgress:
              navigationButtonToGame(lable: "Continue", type: .active, viewModel: gameViewModelSaved)
              navigationButtonToGame(lable: "New game", type: .neutral, viewModel: gameViewModelNewGame)
            }
        }
    }
  
  private func navigationButtonToGame(lable: String, type: SystemButtonStyle, viewModel: GameViewModel) -> some View {
    SystemButton(label: lable, type: type) {
      isGoingToGameScreen = true
    }
    .navigationDestination(isPresented: $isGoingToGameScreen) {
      GameContentView(viewModel: viewModel)
    }
  }
}

#Preview {
    HomeContentView(vm: HomeVM(initialState: .notStarted))
}
