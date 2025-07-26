//
//  HWTMApp.swift
//  HWTM
//
//  Created by Игорь Клевжиц on 21.07.2025.
//

import SwiftUI

@main
struct HWTMApp: App {
    @StateObject var coordinator = NavigationCoordinator()
    var body: some Scene {
        NavigationStack(path: $coordinator.path) {
            HomeVM(initialState: .notStarted)
                .environmentObject(coordinator)
                .navigationDestination(for: AppScreen.self) { screen in
                    switch screen {
                    case .home:
//                        HomeVM(initialState: .notStarted)
                    case .game:
//                        GameContentView(viewModel: viewModel)
                    case .levelList:
//                        LevelListView()
                    case .gameOver:
//                        GameOverView()
                    }
                }
        }
    }
}
