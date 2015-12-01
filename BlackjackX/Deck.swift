//
//  Deck.swift
//  BlackjackX
//
//  Created by Mike Tangolics on 11/30/15.
//  Copyright (c) 2015 Mike Tangolics. All rights reserved.
//

import Foundation

class Deck
{
    var cards:[Card]
    
    init() {
        cards = [Card]()
        
        for s in Card.Suit.allValues {
            for r in Card.Rank.allValues {
                cards.append(Card(suit:s,rank:r))
            }
        }
    }
    
    func Draw() -> Card {
        let drawnIndex:Int = Int(arc4random_uniform(UInt32(cards.count)))
        
        return cards.removeAtIndex(drawnIndex)
    }
}