//
//  MemoryGame.swift
//  Swifty
//
//  Created by Kylie Benfield on 5/2/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfFaceUpCard: Int? {
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
        
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp  {
                    startBonusTimer()
                } else {
                    stopBonusTime()
                }
            }
        }
        
        var isMatched: Bool = false {
            didSet {
                stopBonusTime()
            }
        }
        
        var content: CardContent
        
        var id: Int
        
        
        // MARK: - Bonus Timer

        // This could give matching bonus points
        // if the user matches the card before a certian amount of time passes while the card is faceup

        // Can be zero which means no bonus time for this card
        var bonusTimeLimit: TimeInterval = 6

        // How long has this card been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }

        // The last time this card was face up
        var lastFaceUpDate: Date?
        // The total time this card has been face up not including the current time it is face up
        var pastFaceUpTime: TimeInterval = 0

        // How much time left for the bonus
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }

        // Percentage of bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }

        // If the card was matched during the bonus time
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }

        // If we are currently face up, unmatched, and still in the bonus time
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }

        // Called when the card moves to the face up state
        private mutating func startBonusTimer() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }

        // Called when the card moves to the face down or matched states
        private mutating func stopBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
    }
}
