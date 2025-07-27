//
//  GameEngine.swift
//  HWTM
//
//  Created by Михаил Болгар on 22.07.2025.
//

enum HintTypes {
    case secondChance
    case askAudience
    case fiftyFifty
}

final class GameEngine {

    func startGame() -> Game {
        Game(currentLevel: 1, earnedPrize: 0, isSecondChanseAvailable: true, isAskAudienceAvailable: true, isFiftyFiftyAvailable: true, isOver: false)
    }

    func answerQuestion(game: inout Game, question: Question, answer: String) -> Game {
        if question.correct_answer == answer {
            game.currentLevel += 1
            game.earnedPrize = 1000 // to add logic connected with levels
        } else {
            game.isOver = true
        }
        return game
    }

    func useHint(game: inout Game, hint: HintTypes) -> Game {
        switch hint {
        case .secondChance:
            game.isSecondChanseAvailable = false
        case .askAudience:
            game.isAskAudienceAvailable = false
        case .fiftyFifty:
            game.isFiftyFiftyAvailable = false
        }
        return game
    }
}
