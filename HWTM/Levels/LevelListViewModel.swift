//
//  LevelListViewModel.swift
//  HWTM
//
//  Created by Дарья on 23.07.2025.
//

import Foundation

class LevelListViewModel: ObservableObject {
  @Published var currentLevel: Int
  @Published var isAnswerRight: Bool
  @Published var levels = [
      Level(number: 15, amount: "$1,000,000", type: .final),
      Level(number: 14, amount: "$500,000", type: .regular),
      Level(number: 13, amount: "$250,000", type: .regular),
      Level(number: 12, amount: "$100,000", type: .regular),
      Level(number: 11, amount: "$50,000", type: .regular),
      Level(number: 10, amount: "$25,000", type: .guaranteed),
      Level(number: 9, amount: "$15,000", type: .regular),
      Level(number: 8, amount: "$12,500", type: .regular),
      Level(number: 7, amount: "$10,000", type: .regular),
      Level(number: 6, amount: "$7,500", type: .regular),
      Level(number: 5, amount: "$5,000", type: .guaranteed),
      Level(number: 4, amount: "$3,000", type: .regular),
      Level(number: 3, amount: "$2,000", type: .regular),
      Level(number: 2, amount: "$1,000", type: .regular),
      Level(number: 1, amount: "$500", type: .regular)
  ]

    init(
         currentLevel: Int,
         isAnswerRight: Bool
    ) {
        self.currentLevel = currentLevel
        self.isAnswerRight = isAnswerRight
    }
    
    var guaranteedWinLevel: Level? {
        guard !isAnswerRight else { return nil }
        let passedLevels = levels.filter { $0.number <= currentLevel }
        return passedLevels.first(where: { $0.type == .guaranteed })
    }

    var lostBeforeGuaranteed: Bool {
        !isAnswerRight && guaranteedWinLevel == nil
    }

    var levelToHighlight: Int? {
        if isAnswerRight {
            return currentLevel
        } else {
            return guaranteedWinLevel?.number
        }
    }
}
