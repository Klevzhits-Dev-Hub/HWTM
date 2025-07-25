//
//  ContentView.swift
//  HWTM
//
//  Created by Игорь Клевжиц on 21.07.2025.
//

import SwiftUI

//struct ContentView: View {
//    @StateObject private var questionModel = QuestionModel()
//    
//    var body: some View {
//        ZStack {
//            GradientBackground()
//            VStack {
//                Group {
//                    if let error = questionModel.errorMessage {
//                        Text(error)
//                            .foregroundColor(.red)
//                    } else if let question = questionModel.questions.first {
//                        Text(question.question)
//                            .font(.headline)
//                    } else {
//                        ProgressView("Загрузка вопроса...")
//                    }
//                }
//                Spacer()
//                
//                AnswerButton(label: "A:", answer: "Answer 1", state: .neutral) {
//                    // действие при нажатии
//                }
//                AnswerButton(label: "A:", answer: "Answer 1", state: .correct) {
//                    // действие при нажатии
//                }
//                AnswerButton(label: "A:", answer: "Answer 1", state: .incorrect) {
//                    // действие при нажатии
//                }
//                AnswerButton(label: "", answer: "Answer 1", state: .chois) {
//                    // действие при нажатии
//                }
//            }
//            .padding()
//        }
//        .onAppear {
//            questionModel.loadQuestions(.hard)
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
