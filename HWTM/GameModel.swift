//
//  GameModel.swift
//  HWTM
//
//  Created by Михаил Болгар on 22.07.2025.
//

import Foundation

struct Game {
   var currentLevel: Int = 0
   var earnedPrize: Int = 0
    // minimum payout?

    // timeLeft - before exit

    var isCallAvailable: Bool = true
    var isAskAudienceAvailable: Bool = true
    var isFiftyFiftyAvailable: Bool = true
    // var isMistakeRightAvailable: Bool

    var isOver: Bool = false
}
