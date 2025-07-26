//
//  ContentView.swift
//  HWTM
//
//  Created by Игорь Клевжиц on 26.07.2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            HomeContentView(vm: HomeVM(initialState: .notStarted))
                .navigationDestination(for: AppScreen.self) { screen in
                    switch screen {
                    case .home:
                        HomeContentView(vm: HomeVM(initialState: .notStarted))
                    case .game:
                        GameContentView(viewModel: GameViewModel(typeOfScreen: .newGame))
                    case .levelList:
                        LevelListView(viewModel: LevelListViewModel(currentLevel: 2, isAnswerRight: true))
                    case .gameOver:
                        GameOverContentView(vm: GameOverVM(initialState: .gameOver, level: 2, prize: 1000))
                    }
                }
        }
    }
}
