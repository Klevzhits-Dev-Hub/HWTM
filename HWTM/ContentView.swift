//
//  ContentView.swift
//  HWTM
//
//  Created by Игорь Клевжиц on 21.07.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var questionModel = QuestionModel()
    let timerController = TimerController()
    
    var body: some View {
        ZStack {
            GradientBackground()
            VStack {
                Group {
                    if let error = questionModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                    } else if let question = questionModel.questions.first {
                        Text(question.question)
                            .font(.headline)
                    } else {
                        ProgressView("Загрузка вопроса...")
                    }
                }
                Spacer()
                TimerView(timerController: timerController)
                AnswerButton(label: "A:", answer: "Answer 1", state: .neutral) {
                    timerController.start()
                }
                AnswerButton(label: "A:", answer: "Answer 1", state: .correct) {
                    timerController.pause()
                }
                AnswerButton(label: "A:", answer: "Answer 1", state: .incorrect) {
                    timerController.repause()
                }
                AnswerButton(label: "", answer: "Answer 1", state: .chois) {
                    timerController.reset()
                }
            }
            .padding()
        }
        .onAppear {
            questionModel.loadQuestions(.hard)
        }
    }
}

#Preview {
    ContentView()
}
