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
    
    var gameCount:UInt = 0
    var winCount:UInt = 0
    
    let CARD_WIDTH:CGFloat = 166
    let CARD_HEIGHT:CGFloat = 242
    let CARD_OFFSET:CGFloat = 30
    
    @IBOutlet weak var gameStatusLabel: NSTextField!
    
    @IBOutlet weak var playerScoreLabel: NSTextField!
        
    @IBOutlet weak var dealerScoreLabel: NSTextField!
    
    @IBOutlet weak var numGamesLabel: NSTextField!
    
    @IBOutlet weak var winrateLabel: NSTextField!
    
    @IBOutlet weak var hitButton: NSButton!
    
    @IBOutlet weak var standButton: NSButton!
    
    @IBOutlet weak var newButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
    }
    
    func newGame() {
        playerCardImages.forEach { $0.removeFromSuperview() }
        dealerCardImages.forEach { $0.removeFromSuperview() }
        playerCardImages = [NSImageView]()
        dealerCardImages = [NSImageView]()
        
        model.New()
        setupBoard()
        model.Deal()
        updateGameStatus()
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
    
    func updateCards(reveal:Bool = false) -> Void {

        // Handle player cards
        for i in 0...model.playerHand.cards.count-1 {
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
        for i in 0...model.dealerHand.cards.count-1 {
            let card = model.dealerHand.cards[i]
            let cardImage:NSImage!
            
            if(i == 1 && model.dealerHand.cards.count == 2 && !reveal) {
                cardImage = NSImage(named: "card_back")
            }
            else {
                cardImage = NSImage(named: getCardImage(card))
            }
            
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
        hitButton.enabled = model.IsPlaying()
        standButton.enabled = model.IsPlaying()
        newButton.enabled = !model.IsPlaying()
    }
    
    func updateScores() -> Void {
        playerScoreLabel.stringValue = "Player: \(model.playerHand.CurrentValue)"
        if(model.IsPlaying()) {
            dealerScoreLabel.stringValue = "Dealer: "

        }
        else {
            dealerScoreLabel.stringValue = "Dealer: \(model.dealerHand.CurrentValue)"
            numGamesLabel.stringValue = "Games: \(++gameCount)"
            if(model.gameStatus == GameStatus.WIN_DEALER_BUST || model.gameStatus == GameStatus.WIN_PLAYER_BLACKJACK) {
                winCount++
            }
            winrateLabel.stringValue = "Winrate: \(Int(round(Double(winCount)/Double(gameCount)*100)))%"
        }
    }

    @IBAction func hitClicked(sender: AnyObject) {
        model.PlayerHit()
        updateScores()
        updateGameStatus()
        updateCards(!model.IsPlaying())
    }
    
    @IBAction func standClicked(sender: AnyObject) {
        model.PlayerStand()
        updateScores()
        updateGameStatus()
        updateCards(true)
    }
    
    @IBAction func newClicked(sender: AnyObject) {
        newGame()
    }
}
