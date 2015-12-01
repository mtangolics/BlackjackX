//
//  Game.swift
//  BlackjackX
//
//  Created by Mike Tangolics on 11/30/15.
//  Copyright © 2015 Mike Tangolics. All rights reserved.
//

import Foundation

class Game {
    var gameDeck:Deck
    var playerHand:Hand
    var dealerHand:Hand
    
    init() {
        gameDeck = Deck()
        playerHand = Hand()
        dealerHand = Hand()
    }
    
    func Deal() -> Void {
        playerHand.AddCard(gameDeck.Draw())
        playerHand.AddCard(gameDeck.Draw())
        
        dealerHand.AddCard(gameDeck.Draw())
        dealerHand.AddCard(gameDeck.Draw())
        
        debugPrint("Player Hand Value: \(playerHand.CurrentValue) Dealer Hand Value: \(dealerHand.CurrentValue)")
    }
    
    func PlayerHit() -> Void {
        playerHand.AddCard(gameDeck.Draw())
    }
    
    func DealerHit() -> Void {
        dealerHand.AddCard(gameDeck.Draw())
    }
    
    func New() -> Void {
        gameDeck = Deck()
        playerHand = Hand()
        dealerHand = Hand()
    }
}