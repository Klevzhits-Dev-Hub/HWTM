//
//  GameContentView.swift
//  HWTM
//
//  Created by KOZLOVA Anastasia on 23.07.2025.
//

import SwiftUI

struct GameContentView: View {
  @ObservedObject var viewModel: GameViewModel
  //@ObservedObject var timerController = TimerController()
  
  @State private var isAnswerRight = false
  @State private var isGoingToLevelScreen = false
  @State private var questionLoad = false
  @State private var showAnswerState = false
  
  @State private var selectedAnswer: String?
  
  var body: some View {
    container {
      VStack {
        if let error = viewModel.errorMessage {
          errorFlow(error: error)
        } else if let question = viewModel.currentQuestion {
          questionFlow(question: question)
        } else {
          progressView()
        }
      }
      .padding()
    }
  }
  
  private func container(@ViewBuilder content: () -> some View) -> some View {
    ZStack {
      GradientBackground()
      content()
    }
    .task {
      guard viewModel.questions != nil else {
        await viewModel.loadQuestions()
        return
      }
    //  timerController.start()
    }
    .navigationDestination(isPresented: $isGoingToLevelScreen) {
      LevelListView(viewModel: LevelListViewModel(
        currentLevel: viewModel.currentLevel,
        isAnswerRight: isAnswerRight)
      )
    }
    .onDisappear() {
      self.viewModel.changeLevel()
    //  timerController.repause()
    }
  }
  
  private func errorFlow(error: String) -> some View {
    Text(error)
      .foregroundColor(.red)
  }
  
  private func questionFlow(question: Question) -> some View {
    VStack {
//      Image(timerController.currntImageName)
//          .resizable()
//          .aspectRatio(contentMode: .fit)
      Text(question.question)
        .font(.headline)
      VStack {
        ForEach(question.allAnswersShuffled, id: \.self) { answer in
          AnswerButton(label: "A:", answer: answer, state: getAnswerState(answer: answer)) {
            selectedAnswer = answer
            showAnswerState = true
            
            if self.viewModel.currentQuestion?.correct_answer == answer {
              self.isAnswerRight = true
            } else {
              self.isAnswerRight = false
            }
            
            Task {
             try? await Task.sleep(for: .seconds(1))
              isGoingToLevelScreen = true
            }
          }
        }
      }
    }
  }
  
  private func getAnswerState(answer: String) -> AnswerState {
    if let selectedAnswer, showAnswerState {
      if selectedAnswer == answer {
        self.viewModel.currentQuestion?.correct_answer == answer ? .correct : .incorrect
      } else {
        .neutral
      }
    } else {
      .neutral
    }
  }
  
  private func progressView() -> some View {
    ProgressView("Загрузка вопроса...")
  }
}


