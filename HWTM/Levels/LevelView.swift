//
//  LevelView.swift
//  HWTM
//
//  Created by Дарья on 22.07.2025.
//

import SwiftUI

struct LevelView: View {
    
    let level: Level
    let isCurrent: Bool
        
        var body: some View {
            HStack {
                Text("\(level.number):")
                    .bold()
                
                Spacer()
                
                Text("\(level.amount)")
                    .bold()
            }

            .padding(10)
            .levelGradient(isCurrent: isCurrent, type: level.type)
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
    LevelView(level: Level(number: 3, amount: "$2000", type: .regular), isCurrent: true)

}


// MARK: - Levels Type Gradient

extension View {
    func levelGradient(isCurrent: Bool, type: LevelType) -> some View {
        let colors: [Color]

        if isCurrent {
            colors = [
                Color(red: 59/255, green: 142/255, blue: 20/255),
                Color(red: 38/255, green: 102/255, blue: 8/255),
                Color(red: 38/255, green: 102/255, blue: 8/255),
                Color(red: 61/255, green: 136/255, blue: 26/255)
            ]
        } else {
            colors = gradientColors(for: type)
        }

        return self.background(
            LinearGradient(
                gradient: Gradient(colors: colors),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }

    private func gradientColors(for type: LevelType) -> [Color] {
        switch type {
        case .regular:
            return [
                Color(red: 2/255, green: 93/255, blue: 131/255),
                Color(red: 2/255, green: 43/255, blue: 84/255),
                Color(red: 2/255, green: 6/255, blue: 49/255),
                Color(red: 8/255, green: 60/255, blue: 102/255)
            ]
        case .guaranteed:
            return [
                Color(red: 96/255, green: 195/255, blue: 251/255),
                Color(red: 17/255, green: 128/255, blue: 191/255),
                Color(red: 29/255, green: 136/255, blue: 197/255),
                Color(red: 38/255, green: 166/255, blue: 238/255)
            ]
        case .final:
            return [
                Color(red: 225/255, green: 207/255, blue: 48/255),
                Color(red: 225/255, green: 154/255, blue: 48/255),
                Color(red: 225/255, green: 207/255, blue: 48/255),
            ]
        }
    }
}
