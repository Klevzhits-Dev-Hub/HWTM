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
    @StateObject var gameOverViewModel: GameOverVM = GameOverVM(initialState: .gameOver,
                                                                level: 2,
                                                                prize: 1000)
    
    var body: some View {
      
      ZStack {
        GradientBackground()
        VStack {
          
          HStack(alignment: .top) {
            Button {
              // делать назад в игру?
            } label: {
              Image(systemName: "chevron.left")
                .font(.title2)
                .foregroundColor(.white)
            }
            
            Spacer()
            
            Button {
              isGoingToGameOverScreen = true
            } label: {
              // скачать картинку с фигмы!!!!!!!
              Image(systemName: "banknote")
                .font(.title2)
                .foregroundColor(.white)
            }
          }
          .padding()
          
          Spacer()
          
          ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
              VStack(spacing: 0) {
                ForEach(viewModel.levels) { level in
                  LevelView(level: level, isCurrent: level.number == viewModel.currentLevel)
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
            }
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
      }
    }
}

#Preview {
  let previewVM = LevelListViewModel(currentLevel: 1, isAnswerRight: false)
  LevelListView(viewModel: previewVM)
}

