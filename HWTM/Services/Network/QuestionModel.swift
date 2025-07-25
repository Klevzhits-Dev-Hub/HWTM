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

class QuestionModel {
  func loadQuestions(_ level: QuestionLevel) async throws -> [Question] {
    return try await APIService.shared.fetchQuestions(level)
  }
}

