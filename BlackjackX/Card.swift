//
//  Card.swift
//  BlackjackX
//
//  Created by Mike Tangolics on 11/30/15.
//  Copyright (c) 2015 Mike Tangolics. All rights reserved.
//

import Foundation

struct Card: CustomStringConvertible {
    enum Suit:String {
        case Hearts = "Hearts", Diamonds = "Diamonds", Clubs = "Clubs", Spades = "Spades"
        
        static let allValues = [Hearts, Diamonds, Clubs, Spades]
    }
    enum Rank:String {
        case Two = "2", Three = "3", Four = "4", Five = "5", Six = "6"
        case Seven = "7", Eight = "8", Nine = "9", Ten = "10"
        case Jack = "J", Queen = "Q", King = "K", Ace = "A"
        
        static let allValues = [Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King, Ace]
    }
    
    let suit:Suit
    let rank:Rank
    
    
    var description:String {
        return "Card[\(rank.rawValue) of \(suit.rawValue)]"
    }
    
    var Value:UInt {
        var val:UInt = 0;
        
        switch rank {
        case .Two:
            val = 2
        case .Three:
            val = 3
        case .Four:
            val = 4
        case .Five:
            val = 5
        case .Six:
            val = 6
        case .Seven:
            val = 7
        case .Eight:
            val = 8
        case .Nine:
            val = 9
        case .Ten, .Jack, .Queen, .King:
            val = 10
        case .Ace:
            val = 11
        default:
            val = 0
        }
        
        return val
    }
    
}