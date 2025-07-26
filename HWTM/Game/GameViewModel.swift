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
  
  var currentQuestion: Question? {
    questions?[currentLevel]
  }
  
  init(typeOfScreen: TypeOfScreen) {
    self.typeOfScreen = typeOfScreen
  }
  
  func hintFiftyFifty() -> [String?] {
    [questions?[currentLevel].incorrect_answers[1], questions?[currentLevel].correct_answer]
  }
  
  func hintAskAudience() -> String {
    let randomValue = Double.random(in: 0...1)
    return randomValue <= 0.7 ? questions?[currentLevel].correct_answer ?? "" : questions?[currentLevel].incorrect_answers[1] ?? ""
  }
  
  func hintCall() -> String {
    let randomValue = Double.random(in: 0...1)
    return randomValue <= 0.8 ? questions?[currentLevel].correct_answer ?? "" : questions?[currentLevel].incorrect_answers[1] ?? ""
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
