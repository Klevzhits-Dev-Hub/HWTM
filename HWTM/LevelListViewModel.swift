//
//  LevelListViewModel.swift
//  HWTM
//
//  Created by Дарья on 23.07.2025.
//

import Foundation

class LevelListViewModel: ObservableObject {
    @Published var levels: [Level]
    @Published var currentLevel: Int

    init(levels: [Level], currentLevel: Int = 1) {
        self.levels = levels
        self.currentLevel = currentLevel
    }
}

