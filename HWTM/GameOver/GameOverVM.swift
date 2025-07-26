//
//  GameOverVM.swift
//  HWTM
//
//  Created by Михаил Болгар on 24.07.2025.
//

import SwiftUI

final class GameOverVM: ObservableObject {
    enum GameResult {
        case gameOver
        case gameWon

        var mainTitle: String {
            switch self {
            case .gameOver:
                return "Game over :("
            case .gameWon:
                return "Congratulations!\nYou've won! 🎉"
            }
        }

        var continueButtonTitle: String {
            switch self {
            case .gameOver:
                return "Try again"
            case .gameWon:
                return "Win more money"
            }
        }
    }

    @Published var gameState: GameResult = .gameOver
    @Published var level: Int
    @Published var prize: Int

    init(initialState: GameResult, level: Int, prize: Int) {
        self.gameState = initialState
        self.level = level
        self.prize = prize

        UserDefaultsService().saveHasPlayed()
        UserDefaultsService().saveBestScore(prize)
    }
}
