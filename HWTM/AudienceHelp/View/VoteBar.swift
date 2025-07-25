//
//  VoteBar.swift
//  HWTM
//
//  Created by Alexander Abanshin on 25.07.2025.
//

import SwiftUI

struct VoteBar: View {
    let percent: Int            
    let color: Color            
    let letter: String          
    let isAnimated: Bool        
    let animationDelay: Double  
    
    var body: some View {
        VStack {
            Text("\(percent)%")
                .font(.footnote).monospacedDigit()
                .padding(.bottom, 5)
                .foregroundColor(.white)
                .opacity(isAnimated ? 1 : 0)
                .animation(.easeIn.delay(animationDelay), value: isAnimated)

            Rectangle()
                .fill(color)
                .frame(width: 70, height: CGFloat(percent) * 3.5)
                .scaleEffect(y: isAnimated ? 1 : 0, anchor: .bottom)
                .animation(.easeOut(duration: 1.5).delay(animationDelay), value: isAnimated)
                .cornerRadius(12)

            Text(letter)
                .font(.title2).bold()
                .foregroundColor(.white)
        }
    }
}


#Preview {
    VoteBar(percent: 50, color: .blue, letter: "A", isAnimated: true, animationDelay: 1)
}
