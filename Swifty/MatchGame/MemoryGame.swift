//
//  MemoryGame.swift
//  Swifty
//
//  Created by Kylie Benfield on 5/2/21.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    init(pairCount: Int, cardContentFactory:(Int) -> CardContent) {
        cards = Array<Card>()
        
        for index in 0..<pairCount {
            let content = cardContentFactory(index)
            cards.append(Card(pair: index * 2 + 1, content: content, id: index * 2))
            cards.append(Card(pair: index * 2, content: content, id: index * 2 + 1))
        }
        
        cards = cards.shuffled()
    }
    
    mutating func selectCard(_ card: Card) {
//        print("Selected Card: \(card)")
        
        let selectedIndex: Int = self.index(of: card)
        self.cards[selectedIndex].isFaceUp = !self.cards[selectedIndex].isFaceUp
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if self.cards[index].id == card.id {
                return index
            }
        }
        
        return 0 // TODO: Wrong index when card is missing
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var pair: Int;
        
        var content: CardContent
        
        var id: Int
    }
}
