//
//  GameModel.swift
//  HWTM
//
//  Created by Михаил Болгар on 22.07.2025.
//

import Foundation

struct Game {
   var currentLevel: Int
   var earnedPrize: Int
    // minimum payout?

    // timeLeft - before exit

    var isSecondChanseAvailable: Bool = true
    var isAskAudienceAvailable: Bool = true
    var isFiftyFiftyAvailable: Bool = true
    // var isMistakeRightAvailable: Bool

    var isOver: Bool = false
  
  
}
