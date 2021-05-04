//
//  MatchGameView.swift
//  Swifty
//
//  Created by Kylie Benfield on 5/2/21.
//

import SwiftUI

struct MatchGameView: View {
    @ObservedObject var gameView: EmojiMemoryGame
    
    var body: some View {
//        HStack {
//            ForEach(gameView.cards) { card in
//                CardView(card: card).onTapGesture {
//                    gameView.selectCard(card: card)
//                }
//            }
//        }
        
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
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    func body (for size: CGSize) -> some View {
        ZStack() {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill()
                    .foregroundColor(Color.blue)
                    
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: strokeWidth)
                    .foregroundColor(Color.white)
                
                Text(card.content)
                    .foregroundColor(.white)
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill()
                    .foregroundColor(Color.green)
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    let cornerRadius: CGFloat = 20.0
    let strokeWidth: CGFloat = 3
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
