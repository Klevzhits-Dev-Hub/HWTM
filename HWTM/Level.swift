//
//  Level.swift
//  HWTM
//
//  Created by Дарья on 22.07.2025.
//

import Foundation

struct Level: Identifiable {
    let id = UUID()
    let number: Int
    let amount: String
    let type: LevelType
}

enum LevelType {
    case regular
    case guaranteed
    case current
    case final
}
