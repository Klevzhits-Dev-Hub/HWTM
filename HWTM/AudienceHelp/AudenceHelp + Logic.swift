//
//  AudenceHelp + Ext.swift
//  HWTM
//
//  Created by Alexander Abanshin on 25.07.2025.
//

import  SwiftUI

extension AudienceHelp {
    func generateVotes(rightAnswerIndex: Int, difficulty: QuestionLevel) -> [Int] {
        var votes = [10, 10, 10, 10] // Базовые значения
        let shouldBeCorrect = Bool.random(probability: difficulty == .hard ? 0.5 : 0.7)
        
        var boostedIndex = rightAnswerIndex
        if !shouldBeCorrect {
            // выбираем случайный неправильный индекс
            let wrongIndices = (0..<4).filter { $0 != rightAnswerIndex }
            boostedIndex = wrongIndices.randomElement()!
        }

        let boostedVotes = Int.random(in: 40...60) // Усиливаем до 40–60%
        votes[boostedIndex] += boostedVotes

        let remaining = 100 - votes.reduce(0, +)
        if remaining > 0 {
            for _ in 0..<remaining {
                votes[Int.random(in: 0..<4)] += 1
            }
        }

        return votes
    }
    
    func randomSplit(_ total: Int, count: Int) -> [Int] {
        guard count > 0 else { return [] }
        
        var numbers = [Int]()
        var remaining = total
        
        for _ in 0..<count-1 {
            let num = Int.random(in: 0...remaining)
            numbers.append(num)
            remaining -= num
        }
        numbers.append(remaining)
        
        return numbers.shuffled()
    }
}

extension Bool {
    static func random(probability: Double) -> Bool {
        return Double.random(in: 0...1) < probability
    }
}
