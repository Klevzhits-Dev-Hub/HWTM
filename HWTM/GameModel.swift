//
//  GameModel.swift
//  HWTM
//
//  Created by Михаил Болгар on 22.07.2025.
//

import Foundation

class Game {
   var currentLevel: Int = 0
   var earnedPrize: Int = 0
    // minimum payout?

    var isCallAvailable: Bool = true
    var isAskAudienceAvailable: Bool = true
    var isAskFriendAvailable: Bool = true
    // var isMistakeRightAvailable: Bool

    var isOver: Bool = false
}
