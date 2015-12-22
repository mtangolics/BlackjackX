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
        var aCount:UInt = 0
        
        for c in cards {
            if(c.rank == Card.Rank.Ace) {
                aCount++
            }
            sum += c.Value
        }
        
        // Handle Ace's dual value
        if(sum > 21 && aCount > 0) {
            var sCount:UInt = 0
            while(sum > 21 && sCount < aCount) {
                sum -= 10
                sCount++
            }
        }
        
        return sum
    }
}