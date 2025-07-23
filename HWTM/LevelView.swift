//
//  LevelView.swift
//  HWTM
//
//  Created by Дарья on 22.07.2025.
//

import SwiftUI

struct LevelView: View {
    let level: Level
    
    var backgroundColor: Color {
        switch level.type {
            case .regular:
            return .blue
        case .current:
            return .green
        case .guaranteed:
            return .cyan
        case .final:
            return .orange
        }
    }
    
    var body: some View {
        HStack {
            Text("\(level.number):")
                .bold()
            
            Spacer()
            
            Text("\(level.amount)")
                .bold()
        }
        .padding(10)
        .background(backgroundColor)
        .clipShape(.capsule)
        .foregroundColor(.white)
        .overlay {
            Capsule()
                .stroke(Color.white, lineWidth: 1)
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    LevelView(level: Level(number: 3, amount: "$2000", type: .current))
}
