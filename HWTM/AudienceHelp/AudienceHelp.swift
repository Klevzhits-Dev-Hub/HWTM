//
//  AudienceHelp.swift
//  HWTM
//
//  Created by Alexander Abanshin on 25.07.2025.
//

import SwiftUI

struct AudienceHelp: View {
    @State private var animatedVotes: [CGFloat] = [0, 0, 0, 0]
    @State private var votes: [Int] = []
    let rightAnswer: Int
    let difficulty: QuestionLevel
    
    var body: some View {
        ZStack {
            Image("audence")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Text("Ask The Audience")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                HStack(alignment: .bottom, spacing: 20) {
                    ForEach(0..<votes.count, id: \.self) { index in
                        VoteBar(
                            percent: votes[index],
                            color: color(for: index),
                            letter: letter(at: index),
                            isAnimated: animatedVotes[index] > 0,
                            animationDelay: Double(index) * 0.3
                        )
                        
                    }
                    
                }
                .padding()
                .cornerRadius(12)
            }
            .padding()
            
            .onAppear {
                votes = generateVotes(rightAnswerIndex: rightAnswer, difficulty: difficulty)
                animateVotes()
            }
        }
    }
}

extension AudienceHelp {
    func color(for index: Int) -> Color {
        switch index {
        case 0: .red
        case 1: .yellow
        case 2: .blue
        default: .green
        }
    }
    
    func letter(at index: Int) -> String {
        ["A", "B", "C", "D"][index]
    }
    
    func animateVotes() {
        for index in 0..<votes.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) + 0.2) {
                animatedVotes[index] = 1.0
            }
        }
    }
}



#Preview {
    AudienceHelp(rightAnswer: 2, difficulty: .hard)
}
