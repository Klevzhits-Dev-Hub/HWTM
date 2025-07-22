//
//  QuestionModel.swift
//  HWTM
//
//  Created by Игорь Клевжиц on 22.07.2025.
//

import Foundation

struct QuestionResponse: Codable {
    let response_code: Int
    let results: [Question]
}

struct Question: Codable {
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
    
    var allAnswersShuffled: [String] {
            (incorrect_answers + [correct_answer]).shuffled()
        }
}

@MainActor
class QuestionModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var errorMessage: String?

    func loadQuestions(_ level: QuestionLevel) {
        Task {
            do {
                questions = try await APIService.shared.fetchQuestions(level)
            } catch {
                print("Ошибка загрузки вопросов: \(error)")
                errorMessage = "Не удалось загрузить вопросы: \(error.localizedDescription)"
            }
        }
    }
}

