//
//  GameModel.swift
//  HWTM
//
//  Created by Михаил Болгар on 22.07.2025.
//

struct Game {
    var currentLevel: Int
    var earnedPrize: Int
    // minimum payout?

    var isCallAvailable: Bool = true
    var isAskAudienceAvailable: Bool = true
    var isAskFriendAvailable: Bool = true
    // var isMistakeRightAvailable: Bool

    var isOver: Bool = false
}
