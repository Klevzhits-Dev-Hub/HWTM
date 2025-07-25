//
//  AudenceHelp + Ext.swift
//  HWTM
//
//  Created by Alexander Abanshin on 25.07.2025.
//

import  SwiftUI

extension AudienceHelp {
    func generateVotes(rightAnswerIndex: Int, difficulty: QuestionLevel) -> [Int] {
        var votes = [10, 10, 10, 10] // Минимальное значение голоса.
        let range = difficulty == .hard ? 15...40 : 25...55
        let correctVotes = Int.random(in: range)
        
        votes[rightAnswerIndex] += correctVotes
        
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

