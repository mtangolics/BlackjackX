//
//  Hand.swift
//  BlackjackX
//
//  Created by Mike Tangolics on 11/30/15.
//  Copyright © 2015 Mike Tangolics. All rights reserved.
//

import Foundation

class Hand {
    
    var cards:[Card]
    
    init() {
        cards = []
    }
    
    func AddCard(c:Card) -> Void {
        cards.append(c)
    }
    
    var CurrentValue:UInt {
        
        var sum:UInt = 0
        
        for c in cards {
            sum += c.Value
        }
        
        return sum
    }
}