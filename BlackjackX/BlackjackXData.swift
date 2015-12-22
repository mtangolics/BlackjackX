//
//  BlackjackXData.swift
//  BlackjackX
//
//  Created by Mike Tangolics on 12/8/15.
//  Copyright © 2015 Mike Tangolics. All rights reserved.
//

import Cocoa

class BlackjackXData: NSObject {
    
    var gameDeck:Deck
    var playerHand:Hand
    var dealerHand:Hand
    
    var gameStatus:GameStatus = GameStatus.PLAYING

    
    override init() {
        gameDeck = Deck()
        playerHand = Hand()
        dealerHand = Hand()
    }
    
    func IsPlaying() -> Bool {
        return gameStatus == GameStatus.PLAYING
    }
    
    func Deal() -> Void {
        playerHand.AddCard(gameDeck.Draw())
        playerHand.AddCard(gameDeck.Draw())
        
        dealerHand.AddCard(gameDeck.Draw())
        dealerHand.AddCard(gameDeck.Draw())
        
        DebugHands()
    }
    
    func PlayerHit() -> Void {
        playerHand.AddCard(gameDeck.Draw())
        
        debugPrint("Player hit added: \(playerHand.cards.last)")
        DebugHands()
        if(playerHand.CurrentValue > 21) {
            gameStatus = GameStatus.LOSE_PLAYER_BUST
        }
    }
    
    func PlayerStand() -> Void {
        DealerPlay()
        CalcWinner()
    }
    
    func DealerPlay() -> Void {
        while(dealerHand.CurrentValue < 21 && dealerHand.CurrentValue < playerHand.CurrentValue) {
            DealerHit()
        }
    }
    
    func CalcWinner() -> Void {
        
        if(dealerHand.CurrentValue == 21 && playerHand.CurrentValue != 21) {
            gameStatus = GameStatus.LOSE_DEALER_BLACKJACK
        }
        else if(playerHand.CurrentValue == 21 && playerHand.cards.count == 2 && dealerHand.CurrentValue != 21) {
            gameStatus = GameStatus.WIN_PLAYER_BLACKJACK
        }
        else if(dealerHand.CurrentValue > 21) {
            gameStatus = GameStatus.WIN_DEALER_BUST
        }
        else if(dealerHand.CurrentValue > playerHand.CurrentValue) {
            gameStatus = GameStatus.LOSE_DEALER_HIGH
        }
        else if(dealerHand.CurrentValue == playerHand.CurrentValue) {
            gameStatus = GameStatus.PUSH
        }
    }
    
    func DealerHit() -> Void {
        dealerHand.AddCard(gameDeck.Draw())
    }

    func DebugHands() -> Void {
        debugPrint("Player Hand Value: \(playerHand.CurrentValue) Dealer Hand Value: \(dealerHand.CurrentValue)")
    }
    
    func New() -> Void {
        gameDeck = Deck()
        playerHand = Hand()
        dealerHand = Hand()
        gameStatus = GameStatus.PLAYING
    }
}
