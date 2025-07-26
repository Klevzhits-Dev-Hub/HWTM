//
//  NavigationCoordinator.swift
//  HWTM
//
//  Created by Игорь Клевжиц on 26.07.2025.
//

import SwiftUI

enum AppScreen: Hashable {
    case home
    case game
    case levelList
    case gameOver
}

final class NavigationCoordinator: ObservableObject {
    @Published var path: [AppScreen] = []
    
    func goTo(_ screen: AppScreen) {
        path.append(screen)
    }
    
    func resetToRoot() {
        path = []
    }
    
    func replaceLast(with screen: AppScreen) {
        guard !path.isEmpty else {
            goTo(screen)
            return
        }
        path.removeLast()
        path.append(screen)
    }
}

