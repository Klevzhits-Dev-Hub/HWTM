//
//  LevelListView.swift
//  HWTM
//
//  Created by Дарья on 22.07.2025.
//

import SwiftUI

struct LevelListView: View {
    @StateObject var viewModel: LevelListViewModel
    @State private var isGoingToGameOverScreen = false
    @StateObject var gameOverViewModel: GameOverVM = GameOverVM(
        initialState: .gameOver,
        level: 2,
        prize: 1000
    )
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            GradientBackground()
            
            VStack {
                
                Spacer()
                
                ScrollViewReader { proxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            ForEach(viewModel.levels) { level in
                                LevelView(
                                    level: level,
                                    isCurrent: level.number == viewModel.levelToHighlight
                                )
                                .id(level.number)
                            }
                        }
                        .padding(.top, 40)
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 60)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            proxy.scrollTo(viewModel.levels.last?.number, anchor: .bottom)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            let prize = viewModel.prizeInfo()
                            gameOverViewModel.level = prize.level
                            gameOverViewModel.prize = prize.amount
                            isGoingToGameOverScreen = true
                        }
                    }
                }
                if viewModel.lostBeforeGuaranteed {
                    Text("Your prize is $0 but happiness is free! :)")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                    Spacer(minLength: 20)
                }
            }
            
            VStack {
                Image("miniLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100)
                    .padding(.top, 30)
                    .shadow(radius: 10)
                Spacer()
            }
            
            .navigationDestination(isPresented: $isGoingToGameOverScreen) {
                GameOverContentView(vm: gameOverViewModel)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    let previewVM = LevelListViewModel(currentLevel: 1, isAnswerRight: false)
    
    NavigationStack {
        LevelListView(viewModel: previewVM)
    }
}
