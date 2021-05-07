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
        Grid(gameView.cards) { card in
            CardView(card: card).onTapGesture {
                gameView.selectCard(card: card)
            }
            .padding(5)
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
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill()
                        .foregroundColor(Color.green)
                }
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
