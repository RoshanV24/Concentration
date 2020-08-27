//
//  Concentration.swift
//  Concentration
//
//  Created by Roshan Virdi on 5/21/20.
//  Copyright © 2020 Roshan Virdi. All rights reserved.
//

import Foundation

class Concentration
{
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFaceUp {
                    if foundIndex == nil{
                    foundIndex = index
                }else{
                    return nil
                }
            }
            }
            return foundIndex
        }
        set {
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                
                
            }else{
                indexOfOneAndOnlyFaceUpCard = index
                
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        var unshuffledCard: [Card] = []
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            unshuffledCard += [card, card]
            
        }
        //Shuffle the cards
        while !unshuffledCard.isEmpty{
            let randomIndex = Int(arc4random_uniform(UInt32(unshuffledCard.count)))
            let card = unshuffledCard.remove(at: randomIndex)
            cards.append(card)
        }
    }
    
}


