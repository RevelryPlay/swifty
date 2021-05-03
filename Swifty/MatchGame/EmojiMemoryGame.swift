//
//  EmojiMemoryGame.swift
//  Swifty
//
//  Created by Kylie Benfield on 5/2/21.
//

import SwiftUI

class EmojiMemoryGame {
    private var game: MemoryGame<String> = EmojiMemoryGame.createGame()
        
    static func createGame() -> MemoryGame<String> {
        let emojois: Array<String> = ["👻", "💀", "☠️", "👽", "👾", "🤖", "🎃", "👍🏻", "😀", "♦︎"]
        return MemoryGame<String>(pairCount: emojois.count) { index in
            return emojois[index]
        }
    }
    
    
    // MARK: - External Access to the Game
    
    var cards: Array<MemoryGame<String>.Card> {
        game.cards
    }
    
    
    // MARK: - Intent(s)
    
    func selectCard(card: MemoryGame<String>.Card) {
        game.selectCard(card: card)
    }
}
