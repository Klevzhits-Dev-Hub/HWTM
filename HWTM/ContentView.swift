//
//  ContentView.swift
//  HWTM
//
//  Created by Игорь Клевжиц on 21.07.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            GradientBackground()
            VStack {
                Spacer()
                
                AnswerButton(label: "A:", answer: "Answer 1", state: .neutral) {
                    // действие при нажатии
                }
                AnswerButton(label: "A:", answer: "Answer 1", state: .correct) {
                    // действие при нажатии
                }
                AnswerButton(label: "A:", answer: "Answer 1", state: .incorrect) {
                    // действие при нажатии
                }
                AnswerButton(label: "", answer: "Answer 1", state: .chois) {
                    // действие при нажатии
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
