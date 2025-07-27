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

    func loadQuestions() async {
        do {
            let easy = try await questionModel.loadQuestions(.easy)
            self.questions = easy
            print("Easy загружены: \(easy.count)")

            Task {
                try? await Task.sleep(nanoseconds: 5_000_000_000) // 5 секунд
                do {
                    let medium = try await questionModel.loadQuestions(.medium)
                    print("Medium загружены: \(medium.count)")
                    await MainActor.run {
                        self.questions?.append(contentsOf: medium)
                    }
                } catch {
                    print("Ошибка при загрузке medium: \(error)")
                }
            }

            Task {
                try? await Task.sleep(nanoseconds: 10_000_000_000) // 10 секунд
                do {
                    let hard = try await questionModel.loadQuestions(.hard)
                    print("Hard загружены: \(hard.count)")
                    await MainActor.run {
                        self.questions?.append(contentsOf: hard)
                    }
                } catch {
                    print("Ошибка при загрузке hard: \(error)")
                }
            }
            print(currentQuestion?.correct_answer ?? "")
        } catch {
            errorMessage = error.localizedDescription
        }
    }

  
  func changeLevel() {
    currentLevel += 1
      print(currentQuestion?.correct_answer ?? "")
  }
  
  func resetLevel() {
    currentLevel = 1
  }
  
  func resetQuestions() {
    questions = nil
  }
  
  func resetModule() {
    resetLevel()
    resetQuestions()
  }
}
