//
//  GameContentView.swift
//  HWTM
//
//  Created by KOZLOVA Anastasia on 23.07.2025.
//

import SwiftUI

struct GameContentView: View {
  @ObservedObject var viewModel: GameViewModel
  
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
      await viewModel.loadQuestions()
    }
  }
  
  private func errorFlow(error: String) -> some View {
    Text(error)
      .foregroundColor(.red)
  }
  
  private func questionFlow(question: Question) -> some View {
    VStack {
      Text(question.question)
        .font(.headline)
      VStack {
        ForEach(question.allAnswersShuffled, id: \.self) { answer in
          AnswerButton(label: answer, answer: answer, state: .neutral) {
            self.viewModel.currentQuestion?.correct_answer == answer ?
            print("Правильно!") :
            print("Неправильно!")
          }
        }
      }
    }
  }
  
  private func progressView() -> some View {
    ProgressView("Загрузка вопроса...")
  }
}


