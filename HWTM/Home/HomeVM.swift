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
        case inProgress
        case gameOver(score: Int)
    }

    @Published var gameState: GameStates = .notStarted
    @Published var hasPlayed: Bool = false /// to show label with the best score
    @Published var showModal: Bool = false
    var count = 0

    func onStartButtonTapped() {
        switch gameState {
        case .notStarted:
            print("show very first screen")
        case .inProgress:
            print("show continue button")
        case .gameOver: // add level and prize
            print("show game over screen")
        }
    }

    func onSupportButtonTapped() {
        let states: [GameStates] = [.inProgress, .gameOver(score: 15000), .notStarted]
        guard count < states.count - 1 else { count = -1; return}
        count += 1
        print(count)
        gameState = states[count]
    }
}
