//
//  SupportContentView.swift
//  HWTM
//
//  Created by Михаил Болгар on 24.07.2025.
//

import SwiftUI

struct SupportContentView: View {

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            GradientBackground()
                .ignoresSafeArea()

            ScrollView {
                VStack (alignment: .leading, spacing: 20) {

                    ZStack {
                        HStack {
                            Button(action: {
                                dismiss()
                            }) {
                                Text("Close")
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        Text("Rules")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    .padding(.top)

                    Text(rulesText)
                        .foregroundColor(.white)
                        .font(.body)
                }
                .padding()
            }
        }
    }

    private var rulesText: String {
            """
            Who Wants to Be a Millionaire is a quiz show where the player answers multiple-choice questions to win increasing amounts of money. The goal is to answer 15 questions correctly to win the top prize of $1,000,000.
            
            1. The player starts with no money and selects one of four answer choices for each question.
            2. Each correct answer increases the prize money, following a fixed money ladder.
            3. If the player answers incorrectly, they may fall back to the last guaranteed prize level or lose everything.
            4. The player can walk away at any point with the money they've earned so far.
            5. There are three lifelines available:
                • 50:50 – removes two incorrect answers.
                • Phone a Friend – the player calls a friend for help.
                • Ask the Audience – poll results from the audience are shown.
            6. Lifelines can be used once per game and are intended to assist with difficult questions.
            7. The game ends when the player either:
                • Answers all 15 questions correctly,
                • Chooses to walk away,
                • Or gives a wrong answer.
            
            Play wisely and good luck!
            """
    }
}

#Preview {
    SupportContentView()
}
