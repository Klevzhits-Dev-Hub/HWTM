//
//  Level.swift
//  HWTM
//
//  Created by Дарья on 22.07.2025.
//

import Foundation

enum Lvl: Int, CaseIterable {
    case question1 = 1
    case question2
    case question3
    case question4
    case question5
    case question6
    case question7
    case question8
    case question9
    case question10
    case question11
    case question12
    case question13
    case question14
    case question15

    var prize: Int {
        switch self {
        case .question1: return 500
        case .question2: return 1000
        case .question3: return 2000
        case .question4: return 3000
        case .question5: return 5000
        case .question6: return 7500
        case .question7: return 10000
        case .question8: return 12500
        case .question9: return 15000
        case .question10: return 25000
        case .question11: return 50000
        case .question12: return 100000
        case .question13: return 250000
        case .question14: return 500000
        case .question15: return 1000000
        }
    }

    var isSafeZone: Bool {
        return self == .question5 || self == .question10
    }

    var next: Lvl? {
        Lvl(rawValue: self.rawValue + 1)
    }
}

struct Level: Identifiable {
    let id = UUID()
    let number: Int
    let amount: String
    let type: LevelType
}

enum LevelType {
    case regular
    case guaranteed
    case final
}
