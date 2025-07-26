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
  
  @State private var isPressedFiftyFifty = false
  @State private var isPressedAskAudiens = false
  @State private var isPressedCall = false
  
  @State private var hintType: HintTypes?
  
  private var lettersArray = ["A: ", "B: ", "C: ", "D: "]
  @State private var shuffled: [String] = []
  @State private var didload = false
  
  @State private var selectedAnswer: String?
  
  init(viewModel: GameViewModel) {
    self.viewModel = viewModel
  }
  
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
    .onAppear() {
      if !didload, viewModel.typeOfScreen == .newGame {
        viewModel.resetModule()
        didload = true
      }
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
      Task {
       try? await Task.sleep(for: .seconds(1))
        hintType = nil
      }
    //  timerController.repause()
    }
  }
  
  private func errorFlow(error: String) -> some View {
    Text(error)
      .foregroundColor(.white)
  }
  
  private func questionFlow(question: Question) -> some View {
    VStack {
//      Image(timerController.currntImageName)
//          .resizable()
//          .aspectRatio(contentMode: .fit)
      Text(question.question)
        .font(.headline)
        .foregroundColor(.white)
      VStack {
        ForEach(Array(question.allAnswersShuffled.enumerated()), id: \.element) { index, answer in
          let answer = hintParsing(answer: answer)
          let label = self.lettersArray[index]
          AnswerButton(label: label, answer: answer, state: getAnswerState(answer: answer, disable: answer.isEmpty)) {
            
            selectedAnswer = answer
            showAnswerState = true
            checkAnswerState(answer: answer)
            
            Task {
             try? await Task.sleep(for: .seconds(1))
              isGoingToLevelScreen = true
            }
          }
        }
      }
      
      HStack {
        HintButton(systemName: "50.circle", isPressed: isPressedFiftyFifty) {
          hintType = .fiftyFifty
          isPressedFiftyFifty = true
        }
        HintButton(systemName: "person.2", isPressed: isPressedAskAudiens) {
          hintType = .askAudience
          isPressedAskAudiens = true
        }
        HintButton(systemName: "phone", isPressed: isPressedCall) {
          hintType = .call
          isPressedCall = true
        }
      }
      .padding()
    }
  }
  
  private func checkAnswerState(answer: String) {
    if self.viewModel.currentQuestion?.correct_answer == answer {
      self.isAnswerRight = true
    } else {
      self.isAnswerRight = false
    }
  }
  
  private func hintParsing(answer: String) -> String {
    var array = [String?]()
    switch hintType {
    case .fiftyFifty:
      array = viewModel.hintFiftyFifty()
    case .askAudience:
      array.append(viewModel.hintAskAudience())
    case .call:
      array.append(viewModel.hintCall())
    default:
      return answer
    }
    if !array.contains(answer) {
      return ""
    }
    return answer
  }
  
  private func getAnswerState(answer: String, disable: Bool) -> AnswerState {
    if disable {
      return .disabled
    }
    
    if let selectedAnswer, showAnswerState {
      if selectedAnswer == answer {
        return self.viewModel.currentQuestion?.correct_answer == answer ? .correct : .incorrect
      } else {
        return .neutral
      }
    } else {
      return .neutral
    }
  }
  
  private func progressView() -> some View {
    ProgressView("Загрузка вопроса...")
  }
}


