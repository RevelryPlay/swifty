//
//  MemoryGame.swift
//  Swifty
//
//  Created by Kylie Benfield on 5/2/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    
    var indexOfFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func selectCard(_ card: Card) {
        if let selectedIndex = cards.firstIndex(matching: card), !cards[selectedIndex].isFaceUp, !cards[selectedIndex].isMatched {
            if let potentialMatch = indexOfFaceUpCard {
                if cards[selectedIndex].content == cards[potentialMatch].content {
                    cards[selectedIndex].isMatched = true;
                    cards[potentialMatch].isMatched = true;
                }
                
                cards[selectedIndex].isFaceUp = true
                
            } else {
                indexOfFaceUpCard = selectedIndex
            }
        }
    }
    
    
    init(pairCount: Int, cardContentFactory:(Int) -> CardContent) {
        cards = Array<Card>()
        
        for index in 0..<pairCount {
            let content = cardContentFactory(index)
            cards.append(Card(content: content, id: index * 2))
            cards.append(Card(content: content, id: index * 2 + 1))
        }
        
        cards = cards.shuffled()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        
        var content: CardContent
        
        var id: Int
    }
}
