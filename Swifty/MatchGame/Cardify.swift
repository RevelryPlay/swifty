//
//  Cardify.swift
//  Swifty
//
//  Created by Kylie Benfield on 5/9/21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill()
                    .foregroundColor(Color.blue)

                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: strokeWidth)
                    .foregroundColor(Color.white)
                
                content
            }
            .opacity(isFaceUp ? 1 : 0)


            RoundedRectangle(cornerRadius: cornerRadius)
                .fill()
                .foregroundColor(Color.green)
                .opacity(isFaceUp ? 0 : 1)
            
        }
        .rotation3DEffect(
            Angle.degrees(rotation),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
        
    }
    
    // MARK: - Drawing Constants
    private let cornerRadius: CGFloat = 20.0
    private let strokeWidth: CGFloat = 3
    
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
