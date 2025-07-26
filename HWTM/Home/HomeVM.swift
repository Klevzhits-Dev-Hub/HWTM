//
//  HomeVM.swift
//  HWTM
//
//  Created by Михаил Болгар on 22.07.2025.
//

import SwiftUI

final class HomeVM: ObservableObject {
    @EnvironmentObject var coordinator: NavigationCoordinator
    enum GameStates {
        case notStarted
        case inProgress // to remove later
    }

    @Published var gameState: GameStates = .notStarted
    @Published var hasPlayed: Bool = false /// to show label with the best score
    @Published var showModal: Bool = false
    @Published var isGameStarted: Bool = false /// to show button "continue"

    var count = 0

    /*
     isGameStarted will be used to show the "continue" button

     case gameOver -- will be a separated screen later:
     2. level - Int
     3. score - Int
     */

    init(initialState: GameStates) {
        self.gameState = initialState
    }

    func onStartButtonTapped() {
        switch gameState {
        case .notStarted:
            print("show very first screen")
        case .inProgress:
            print("show continue button")
        }
    }

    func onSupportButtonTapped() {
        let states: [GameStates] = [.inProgress, .notStarted]
        guard count < states.count - 1 else { count = -1; return}
        count += 1
        print(count)
        gameState = states[count]
    }
}
