//
//  GameStatus.swift
//  BlackjackX
//
//  Created by Mike Tangolics on 12/10/15.
//  Copyright © 2015 Mike Tangolics. All rights reserved.
//

import Foundation

enum GameStatus:String {
    case PLAYING = ""
    case WIN_DEALER_BUST = "Dealer busts. You win!"
    case WIN_PLAYER_BLACKJACK = "You have blackjack. You win!"
    case LOSE_DEALER_BLACKJACK = "Dealer has blackjack. You lose!"
    case LOSE_PLAYER_BUST = "You bust. You lose!"
    case LOSE_DEALER_HIGH = "Dealer is higher. You lose!"
    case PUSH = "Push. Nobody wins!"
}