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
    case disabled
}

struct AnswerButton: View {
    let label: String
    let answer: String
    let state: AnswerState
    let action: () -> Void
    
    
    var body: some View {
        
        GeometryReader { geometry in
            
            Button(action: action) {

              ZStack {
                CustomButtonShape()
                  .fill(
                    LinearGradient(
                      gradient: Gradient(colors: gradientColors(for: state)),
                      startPoint: .top,
                      endPoint: .bottom
                    )
                  )
                  .frame(width: geometry.size.width * 0.9, height: 56)
                
                CustomButtonShape()
                  .stroke(Color.white, lineWidth: 2)
                  .frame(width: geometry.size.width * 0.9, height: 56)
                
                if state != .disabled {
                  HStack(spacing: 4) {
                    Text("\(label)")
                      .foregroundColor(.orange)
                      .bold()
                    Text(answer)
                      .foregroundColor(.white)
                  }
                  .font(.headline)
                }
              }
            }
            .disabled(state == .disabled)
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
    let type: SystemButtonStyle /// for managing states
    let state: AnswerState /// for picking colors
    let action: () -> Void

    var body: some View {

        GeometryReader { geometry in

            Button(action: action) {

                ZStack {
                    CustomButtonShape()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: gradientColors(for: state)),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: geometry.size.width * 0.9, height: 56)

                    CustomButtonShape()
                        .stroke(Color.white, lineWidth: 2)
                        .frame(width: geometry.size.width * 0.9, height: 56)

                    Text(label)
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
            .frame(width: geometry.size.width, height: 56, alignment: .center)
        }
        .frame(height: 56)
    }
}

struct HintButton: View {
    let systemName: String
    var isPressed: Bool
    let action: () -> Void
    
    var body: some View {
      Button(action: action) {
        
        Image(systemName: systemName)
          .font(.system(size: 20, weight: .medium))
          .foregroundColor(.white)
          .frame(width: 70, height: 50)
          .background(
            Capsule()
              .strokeBorder(Color.white, lineWidth: 2)
              .background(Capsule().fill(isPressed ? Color.gray : Color.blue))
              .clipShape(Capsule()))
          .buttonStyle(PlainButtonStyle())
      }
      .disabled(isPressed)
      .opacity(isPressed ? 0.5 : 1)
    }
}


#Preview {
    GradientBackground()
}

// MARK: - AnswerButton Gradient
    
    private func gradientColors(for state: AnswerState) -> [Color] {
        switch state {
        case .neutral:
            return [
                Color(red: 2/255, green: 93/255, blue: 131/255),
                Color(red: 2/255, green: 43/255, blue: 84/255),
                Color(red: 2/255, green: 6/255, blue: 49/255),
                Color(red: 8/255, green: 60/255, blue: 102/255)
            ]
        case .correct:
            return [
                Color(red: 59/255, green: 142/255, blue: 20/255),
                Color(red: 38/255, green: 102/255, blue: 8/255),
                Color(red: 38/255, green: 102/255, blue: 8/255),
                Color(red: 61/255, green: 136/255, blue: 26/255)
            ]
        case .incorrect:
            return [
                Color(red: 180/255, green: 65/255, blue: 28/255),
                Color(red: 131/255, green: 33/255, blue: 2/255),
                Color(red: 131/255, green: 33/255, blue: 2/255),
                Color(red: 180/255, green: 62/255, blue: 25/255)
            ]
        case .chois:
            return [
                Color(red: 225/255, green: 207/255, blue: 48/255),
                Color(red: 225/255, green: 154/255, blue: 48/255),
                Color(red: 225/255, green: 207/255, blue: 48/255)
            ]
        case .disabled:
          return [
              Color(red: 2/255, green: 93/255, blue: 131/255),
              Color(red: 2/255, green: 43/255, blue: 84/255),
              Color(red: 2/255, green: 6/255, blue: 49/255),
              Color(red: 8/255, green: 60/255, blue: 102/255)
          ]
        }
    }


