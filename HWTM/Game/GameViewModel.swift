//
//  GameViewModel.swift
//  HWTM
//
//  Created by KOZLOVA Anastasia on 23.07.2025.
//

import SwiftUI

@MainActor
final class GameViewModel: ObservableObject {

  private var questionModel = QuestionModel()
  @Published var questions: [Question]?
  @Published var errorMessage: String?
  @Published var currentLevel = 0
  
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
}
