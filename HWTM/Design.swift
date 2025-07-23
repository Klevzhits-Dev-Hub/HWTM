//
//  Design.swift
//  HWTM
//
//  Created by Игорь Клевжиц on 21.07.2025.
//

import SwiftUI

struct GradientBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(UIColor(red: 59/255, green: 75/255, blue: 143/255, alpha: 1)),Color(UIColor(red: 16/255, green: 14/255, blue: 21/255, alpha: 1))], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            RadialGradient(colors: [Color(UIColor(red: 86/255, green: 174/255, blue: 249/255, alpha: 0.8)),Color(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0))], center: UnitPoint(x: 0.1, y: 0.3), startRadius: 1, endRadius: 321)
                .ignoresSafeArea()
                .blur(radius: 87)
            
            RadialGradient(colors: [Color(UIColor(red: 86/255, green: 174/255, blue: 249/255, alpha: 1)),Color(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0))], center: UnitPoint(x: 0.8, y: 0.7), startRadius: 1, endRadius: 179)
                .ignoresSafeArea()
                .blur(radius: 87)
        }
        
    }
}

// todo: по-хорошему нужна единая базовая модель кнопки, чтобы избежать повторения кода, но не уверен как это делать на суи
/// play buttons
enum AnswerState {
    case neutral
    case correct
    case incorrect
    case chois
}

struct AnswerButton: View {
    let label: String
    let answer: String
    let state: AnswerState
    let action: () -> Void
    
    private var backgroundColor: Color {
        switch state {
        case .neutral:
            return .blue
        case .correct:
            return .green
        case .incorrect:
            return .red
        case .chois:
            return .orange
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: action) {
                HStack(spacing: 4) {
                    Text("\(label)")
                        .foregroundColor(.orange)
                        .bold()
                    Text(answer)
                        .foregroundColor(.white)
                }
                .frame(width: geometry.size.width * 0.9, height: 56)
                .background(backgroundColor)
                .font(.headline)
                .clipShape(Capsule())
            }
            .frame(width: geometry.size.width, height: 56, alignment: .center)
        }
        .frame(height: 56)
    }
}

/// system buttons
enum SystemButtonStyle {
    case neutral
    case active
}

struct SystemButton: View {
    let label: String
    let type: SystemButtonStyle
    let action: () -> Void

    private var backgroundColor: Color {
        switch type {
        case .neutral:
            return .blue
        case .active:
            return .yellow
        }
    }

    var body: some View {
        Button(action: action) {
            Text(label)
                .fontWeight(.bold)
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding(.horizontal, 40)
                .shadow(radius: 5)
        }
    }
}

#Preview {
    GradientBackground()
}
