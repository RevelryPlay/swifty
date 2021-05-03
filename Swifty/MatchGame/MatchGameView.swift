//
//  ContentView.swift
//  Swifty
//
//  Created by Kylie Benfield on 5/2/21.
//

import SwiftUI

struct MatchGameView: View {
    var gameView: EmojiMemoryGame
    
    var body: some View {
        let chunks: Array<Array<MemoryGame.Card>> = gameView.cards.chunked(into: 4);
        
        return VStack() {
            ForEach(0..<chunks.count)  { i in
                let row = chunks[i]
                HStack() {
                    ForEach(row) { (card: MemoryGame.Card) in
                        CardView(card: card).onTapGesture {
                            gameView.selectCard(card: card)
                        }
                    }
                }
            }
        }
    }
}

struct MatchGameView_Previews: PreviewProvider {
    static var previews: some View {
        MatchGameView(gameView: EmojiMemoryGame())
            .preferredColorScheme(ColorScheme.dark)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack() {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 20.0)
                    .fill()
                    .foregroundColor(Color.blue)
                    
                RoundedRectangle(cornerRadius: 20.0)
                    .stroke(lineWidth: 2)
                    .foregroundColor(Color.white)
                
                Text(card.content)
                    .foregroundColor(.white)
                    .font(Font.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 20.0)
                    .fill()
                    .foregroundColor(Color.green)
            }
        }
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
