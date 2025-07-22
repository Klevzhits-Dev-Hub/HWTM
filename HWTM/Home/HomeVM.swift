//
//  HomeVM.swift
//  HWTM
//
//  Created by Михаил Болгар on 22.07.2025.
//

import SwiftUI

final class HomeVM: ObservableObject {
    enum GameStates {
        case notStarted
        case started
        case inProgress
        case gameOver
    }

    @Published var gameState: GameStates = .notStarted
    var count = 0

    func onStartButtonTapped() {
        switch gameState {
        case .notStarted:
            print("show very first screen")
        case .started:
            print("show best score")
        case .inProgress:
            print("show continue button")
        case .gameOver: // add level and prize
            print("show game over screen")
        }
    }

    func onSupportButtonTapped() {
        let states: [GameStates] = [.inProgress, .gameOver, .notStarted, .started]
        guard count < states.count - 1 else { count = 0; return}
        count += 1
        gameState = states[count]
    }
}
