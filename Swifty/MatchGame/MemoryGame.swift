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
    
    func selectCard(card: Card) {
        print("Selected Card: \(card)")
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var pair: Int;
        
        var content: CardContent
        
        var id: Int
    }
}
