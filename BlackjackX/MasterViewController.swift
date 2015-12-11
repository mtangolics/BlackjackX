//
//  MasterViewController.swift
//  BlackjackX
//
//  Created by Mike Tangolics on 12/3/15.
//  Copyright © 2015 Mike Tangolics. All rights reserved.
//

import Cocoa

class MasterViewController: NSViewController {
    
    var model = BlackjackXData()
    var playerCardImages = [NSImageView]()
    var dealerCardImages = [NSImageView]()
    
    let CARD_WIDTH:CGFloat = 166
    let CARD_HEIGHT:CGFloat = 242
    let CARD_OFFSET:CGFloat = 30
    
    @IBOutlet weak var gameStatusLabel: NSTextField!
    
    @IBOutlet weak var playerScoreLabel: NSTextField!
    
    @IBOutlet weak var dealerScoreLabel: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        setupBoard()
        model.Deal()
        updateCards()
        updateScores()
    }
    
    func setupBoard() -> Void {
        let topPosition = view.frame.height - CARD_HEIGHT - 50
        let playerAnchorImage:NSImageView = NSImageView(frame: NSRect(x:50,y:topPosition,width:CARD_WIDTH,height:CARD_HEIGHT))
        
        playerAnchorImage.image = NSImage(named: "black_joker")
        
        playerCardImages.append(playerAnchorImage)
        view.addSubview(playerAnchorImage)
        
        let dealerAnchorImage:NSImageView = NSImageView(frame: NSRect(x:450,y:topPosition,width:CARD_WIDTH,height:CARD_HEIGHT))
        
        dealerAnchorImage.image = NSImage(named: "red_joker")
        
        dealerCardImages.append(dealerAnchorImage)
        view.addSubview(dealerAnchorImage)
    }
    
    func updateCards() -> Void {

        // Handle player cards
        for(var i = 0; i < model.playerHand.cards.count; i++) {
            let card = model.playerHand.cards[i]
            let cardImage = NSImage(named: getCardImage(card))
            
            if(i >= playerCardImages.count) {
                let xOffset:CGFloat = playerCardImages.last!.frame.origin.x + CARD_OFFSET
                let yOffset:CGFloat = playerCardImages.last!.frame.origin.y - CARD_OFFSET
                let newImage = NSImageView(frame:NSRect(x:xOffset,y:yOffset,width:CARD_WIDTH,height:CARD_HEIGHT))
                newImage.image = cardImage
                playerCardImages.append(newImage)
                view.addSubview(newImage)
            }
            else {
                playerCardImages[i].image = cardImage
            }
        }
        // Handle dealer cards
        for(var i = 0; i < model.dealerHand.cards.count; i++) {
            let card = model.dealerHand.cards[i]
            let cardImage = NSImage(named: getCardImage(card))
            
            if(i >= dealerCardImages.count) {
                let xOffset:CGFloat = dealerCardImages.last!.frame.origin.x + CARD_OFFSET
                let yOffset:CGFloat = dealerCardImages.last!.frame.origin.y - CARD_OFFSET
                let newImage = NSImageView(frame:NSRect(x:xOffset,y:yOffset,width:CARD_WIDTH,height:CARD_HEIGHT))
                newImage.image = cardImage
                dealerCardImages.append(newImage)
                view.addSubview(newImage)
            }
            else {
                dealerCardImages[i].image = cardImage
            }
        }
    }
    
    func getCardImage(c:Card) -> String {
        return c.rank.rawValue.lowercaseString + "_of_" + c.suit.rawValue.lowercaseString
    }
    
    func updateGameStatus() -> Void {
        gameStatusLabel.stringValue = model.gameStatus.rawValue
    }
    
    func updateScores() -> Void {
        playerScoreLabel.stringValue = "Player: \(String(model.playerHand.CurrentValue))"
        dealerScoreLabel.stringValue = "Dealer: \(model.dealerHand.CurrentValue)"
    }

    @IBAction func hitButton(sender: AnyObject) {
        model.PlayerHit()
        updateCards()
        updateScores()
        updateGameStatus()
    }
    
    @IBAction func standButton(sender: AnyObject) {
        model.PlayerStand()
        updateCards()
        updateScores()
        updateGameStatus()
    }
}
