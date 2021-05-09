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
        VStack{
            Grid(gameView.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear) {
                        gameView.selectCard(card: card)
                    }
                }
                .padding(5)
            }
            
            Button(action: {
                withAnimation(.easeInOut) {
                    self.gameView.resetGame()
                }
                    
            }, label: {
                Text("New Game")
            })
        }
    }
}

struct MatchGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        
        game.selectCard(card: game.cards[Int.random(in: 0..<10)])
        game.selectCard(card: game.cards[Int.random(in: 5..<15)])
        
        return MatchGameView(gameView: game)
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
    
    @State private var animatedTimeRemaining: Double = 0
    
    private func startTimerAnimation() {
        animatedTimeRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedTimeRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body (for size: CGSize) -> some View {
        if (card.isFaceUp || !card.isMatched) {
            ZStack {
                Group {
                    if (card.isConsumingBonusTime) {
                        TimerShape(
                            startAngle: Angle.degrees(0-90),
                            endAngle: Angle.degrees(-animatedTimeRemaining * 360-90),
                            clockwise: true
                        )
                        .onAppear {
                            startTimerAnimation()
                        }
                    } else {
                        TimerShape(
                            startAngle: Angle.degrees(0-90),
                            endAngle: Angle.degrees(-card.bonusRemaining * 360-90),
                            clockwise: true
                        )
                    }
                }
                .padding(4)
                .opacity(0.4)
                

                Text(card.content)
                .foregroundColor(.white)
                .font(Font.system(size: fontSize(for: size)))
                .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                .animation(card.isMatched ? Animation.linear(duration: 1).repeatCount(2, autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
            
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}
