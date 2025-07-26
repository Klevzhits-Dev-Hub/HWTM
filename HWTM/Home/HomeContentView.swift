//
//  HomeContentView.swift
//  HWTM
//
//  Created by Михаил Болгар on 17.07.2025.
//

import SwiftUI

struct HomeContentView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    @ObservedObject var vm: HomeVM
    @StateObject var gameViewModelNewGame: GameViewModel = GameViewModel(typeOfScreen: .newGame)
    @StateObject var gameViewModelSaved: GameViewModel = GameViewModel(typeOfScreen: .saved)
    @State private var isGoingToGameScreenNew = false
    @State private var isGoingToGameScreenContinue = false

    var body: some View {
        ZStack {
            GradientBackground()

            GeometryReader { geometry in
                VStack {
                    Spacer()
                    VStack(alignment: .center, spacing: 24) {
                        logoView(geometry: geometry)
                        labelsView(geometry: geometry)
                    }

                    Spacer()
                    buttonsView(geometry: geometry)
                        .padding(.bottom, 12)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
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
        VStack(spacing: 12) {
            switch vm.gameState {
            case .notStarted, .inProgress:
                Text("Who Wants\nto be a Millioner")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)

                if vm.hasPlayed == true {
                    VStack(alignment: .center, spacing: .zero) {
                        Text("All-time Best Score")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)

                        bestScoreView()
                    }
                }
            }
        }
        .frame(height: geometry.size.height * 0.2)
    }

    private func bestScoreView() -> some View {
        HStack(alignment: .center, spacing: .zero) {
            Text("$\(vm.getBestScore())")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Image("coin")
                .resizable()
                .scaledToFit()
                .frame(width: 45, height: 45)
        }
    }

    private func buttonsView(geometry: GeometryProxy) -> some View {
        VStack(spacing: 14) {

//            switch vm.gameState {
//            case .notStarted:
//                SystemButton(label: "New Game", type: .active, state: .chois) {
//                    isGoingToGameScreen = true
//                    }
//                .navigationDestination(isPresented: $isGoingToGameScreen) {
//                    GameContentView(viewModel: GameViewModel(typeOfScreen: .newGame))
//                }
//            case .inProgress:
                SystemButton(label: "Continue", type: .active, state: .chois) {
                    isGoingToGameScreenContinue = true
                    }
                .navigationDestination(isPresented: $isGoingToGameScreenContinue) {
                    GameContentView(viewModel: GameViewModel(typeOfScreen: .saved))
                }
                SystemButton(label: "New Game", type: .active, state: .neutral) {
                    isGoingToGameScreenNew = true
                    }
                .navigationDestination(isPresented: $isGoingToGameScreenNew) {
                    GameContentView(viewModel: GameViewModel(typeOfScreen: .newGame))
                }
//            }
        }
    }
  
    private func navigationButtonToGame(lable: String, type: SystemButtonStyle, viewModel: GameViewModel, state: AnswerState) -> some View {
      SystemButton(label: lable, type: type, state: state) {
          isGoingToGameScreenNew = true
          vm.gameState = .inProgress
//          coordinator.goTo(.game)
    }
    .navigationDestination(isPresented: $isGoingToGameScreenNew) {
      GameContentView(viewModel: viewModel)
    }
  }
}

#Preview {
    HomeContentView(vm: HomeVM(initialState: .notStarted))
}
