//
//  GameViewModel.swift
//  HWTM
//
//  Created by KOZLOVA Anastasia on 23.07.2025.
//

import SwiftUI

enum TypeOfScreen {
  case saved
  case newGame
}

@MainActor
final class GameViewModel: ObservableObject {

  private var questionModel = QuestionModel()
  @Published var questions: [Question]?
  @Published var errorMessage: String?
  @Published var currentLevel = 0
  @Published var typeOfScreen: TypeOfScreen
  
  init(typeOfScreen: TypeOfScreen) {
    self.typeOfScreen = typeOfScreen
  }
  
  var currentQuestion: Question? {
    questions?[currentLevel]
  }

  func loadQuestions() async {
    do {
      questions = try await questionModel.loadQuestions(.easy)
    } catch {
      errorMessage = error.localizedDescription
    }
  }
  
  func changeLevel() {
    currentLevel += 1
  }
  
  func resetLevel() {
    currentLevel = 0
  }
  
  func resetQuestions() {
    questions = nil
  }
  
  func resetModule() {
    resetLevel()
    resetQuestions()
  }
}
