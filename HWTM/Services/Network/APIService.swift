//
//  APIService.swift
//  HWTM
//
//  Created by Игорь Клевжиц on 22.07.2025.
//

import Foundation

enum QuestionLevel {
    case easy
    case medium
    case hard
}

final class APIService {
    static let shared = APIService()
    
    private init() {}
    
    func fetchQuestions(_ level: QuestionLevel) async throws -> [Question] {
        var strLevel = ""
        switch level {
        case .easy:
            strLevel = "easy"
        case .medium:
            strLevel = "medium"
        case .hard:
            strLevel = "hard"
        }
        guard let url = URL(string: "https://opentdb.com/api.php?amount=5&difficulty=\(strLevel)&type=multiple") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let response = try decoder.decode(QuestionResponse.self, from: data)
        return response.results
    }
}
