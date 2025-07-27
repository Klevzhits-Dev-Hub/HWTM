//
//  GameContentView.swift
//  HWTM
//
//  Created by KOZLOVA Anastasia on 23.07.2025.
//

import SwiftUI

struct GameContentView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    @State private var showAskAudienceSheet = false
    @State private var correctAnswerIndex: Int?
  @ObservedObject var viewModel: GameViewModel
  @ObservedObject var timerController = TimerController()
  
  @State private var isAnswerRight = false
  @State private var isGoingToLevelScreen = false
  @State private var questionLoad = false
  @State private var showAnswerState = false
    @State private var showFinalAnswerState = false
  
  @State private var isPressedFiftyFifty = false
  @State private var isPressedAskAudiens = false
    @State private var isSecondChanceUsed = false
    @State private var hasUsedSecondChanceThisTurn = false
  
  @State private var hintType: HintTypes?
  
  private var lettersArray = ["A: ", "B: ", "C: ", "D: "]
  @State private var shuffled: [String] = []
  @State private var didload = false
  
  @State private var selectedAnswer: String?
  
  init(viewModel: GameViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    container {
      VStack {
        if let error = viewModel.errorMessage {
          errorFlow(error: error)
        } else if let question = viewModel.currentQuestion {
          questionFlow(question: question)
        } else {
          progressView()
        }
      }
      .padding()
    }
  }
  
  private func container(@ViewBuilder content: () -> some View) -> some View {
    ZStack {
      GradientBackground()
      content()
    }
    .onAppear() {
        hintType = nil
        AnswersMusic.shared.stopMusic()
        selectedAnswer = nil
        showAnswerState = false
        showFinalAnswerState = false
        isAnswerRight = false
      if !didload, viewModel.typeOfScreen == .newGame {
        viewModel.resetModule()
        didload = true
      }
        timerController.start()
        timerController.onTimeout = {
            isGoingToLevelScreen = true
        }
    }
    .task {
      guard viewModel.questions != nil else {
        await viewModel.loadQuestions()
        return
      }
    }
    .navigationDestination(isPresented: $isGoingToLevelScreen) {
      LevelListView(viewModel: LevelListViewModel(
        currentLevel: viewModel.currentLevel,
        isAnswerRight: isAnswerRight)
      )
    }
    .sheet(isPresented: $showAskAudienceSheet) {
        if viewModel.currentLevel < 11 {
            AudienceHelp(rightAnswer: correctAnswerIndex ?? 0, difficulty: .easy)
        } else {
            AudienceHelp(rightAnswer: correctAnswerIndex ?? 0, difficulty: .hard)
        }
    }
    .onChange(of: showAskAudienceSheet) { isShown in
        if !isShown {
            timerController.repause()
        }
    }
    .onDisappear() {
      if isGoingToLevelScreen {
        self.viewModel.changeLevel()
      }
      Task {
       try? await Task.sleep(for: .seconds(1))
        hintType = nil
      }
    //  timerController.repause()
    }
    .navigationBarBackButtonHidden(true)
  }
  
  private func errorFlow(error: String) -> some View {
    Text(error)
      .foregroundColor(.white)
  }
  
  private func questionFlow(question: Question) -> some View {
    return VStack {
        HStack {
            Image(systemName: "arrow.left")
                .font(.title2)
                .foregroundStyle(.white)
            
            Spacer()
            
            VStack {
                Text("QUESTION #\(viewModel.currentLevel)")
                    .font(.body)
                    .foregroundStyle(.gray)
                Text("$\(Lvl.allCases[viewModel.currentLevel - 1].prize)")
                    .font(.body)
                    .foregroundStyle(.white)
            }
            
            Spacer()
            
            Button(action: {
                if viewModel.currentLevel > 1 {
                    timerController.pause()
                    viewModel.currentLevel -= 1
                    isAnswerRight = true
                    isGoingToLevelScreen = true
                }
            }) {
                Image(systemName: "banknote")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            .disabled(selectedAnswer != nil)
        }
        .padding(.horizontal, 32)
        .frame(maxWidth: .infinity)
        
      Image(timerController.currntImageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
            
        Spacer()
      Text(question.question)
            .font(.title2)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
        
        Spacer()
      VStack {
        ForEach(Array(question.allAnswersShuffled.enumerated()), id: \.element) { index, answer in
          let answer = hintParsing(answer: answer)
          let label = self.lettersArray[index]
            AnswerButton(label: label, answer: answer, state: getAnswerState(answer: answer, disable: answer.isEmpty)) {
                
                selectedAnswer = answer
                showAnswerState = true
                showFinalAnswerState = false
                checkAnswerState(answer: answer)
                
                timerController.pause()
                
                if isAnswerRight {
                    AnswersMusic.shared.correctAnswerPlay()
                } else {
                    AnswersMusic.shared.wrongAnswerPlay()
                }
                
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    
                    if !isAnswerRight && !isSecondChanceUsed {
                        if let index = viewModel.currentQuestion?.allAnswersShuffled.firstIndex(of: answer) {
                            viewModel.currentQuestion?.allAnswersShuffled[index] = ""
                        }
                        selectedAnswer = nil
                        isSecondChanceUsed = true
                        return
                    }
                    showFinalAnswerState = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isGoingToLevelScreen = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            if isAnswerRight {
                                isGoingToLevelScreen = false
                            }
                        }
                    }
                }
            }
            .disabled(selectedAnswer != nil)
        }
      }
      
      HStack(spacing: 12) {
        HintButton(systemName: "50.circle", isPressed: isPressedFiftyFifty) {
          hintType = .fiftyFifty
          isPressedFiftyFifty = true
        }
        .disabled(selectedAnswer != nil)
        HintButton(systemName: "person.2", isPressed: isPressedAskAudiens) {
            if let correctAnswer = viewModel.currentQuestion?.correct_answer,
               let index = viewModel.currentQuestion?.allAnswersShuffled.firstIndex(of: correctAnswer) {
                correctAnswerIndex = index
                showAskAudienceSheet = true
                isPressedAskAudiens = true
                timerController.pause()
            }
        }
        .disabled(selectedAnswer != nil)
        HintButton(systemName: "heart", isPressed: isSecondChanceUsed) {
        }
        .disabled(selectedAnswer != nil)
      }
      .padding()
    }
  }
  
    private func checkAnswerState(answer: String) {
        let isCorrect = self.viewModel.currentQuestion?.correct_answer == answer
        
        if isCorrect {
            self.isAnswerRight = true
            return
        }
        
        if hintType == .secondChance && !hasUsedSecondChanceThisTurn {
            hasUsedSecondChanceThisTurn = true
            return
        }
        
        self.isAnswerRight = false
    }
  
  private func hintParsing(answer: String) -> String {
    var array = [String?]()
    switch hintType {
    case .fiftyFifty:
      array = viewModel.hintFiftyFifty()
    case .askAudience:
      array.append(viewModel.hintAskAudience())
    case .secondChance: break
//      array.append(viewModel.second())
    default:
      return answer
    }
    if !array.contains(answer) {
      return ""
    }
    return answer
  }
  
    private func getAnswerState(answer: String, disable: Bool) -> AnswerState {
        if disable {
            return .disabled
        }

        guard let selectedAnswer = selectedAnswer else {
            return .neutral
        }

        if showAnswerState {
            if showFinalAnswerState {
                if answer == selectedAnswer {
                    return answer == viewModel.currentQuestion?.correct_answer ? .correct : .incorrect
                } else if answer == viewModel.currentQuestion?.correct_answer {
                    return .correct
                } else {
                    return .neutral
                }
            } else {
                return answer == selectedAnswer ? .chois : .neutral
            }
        }

        return .neutral
    }
  
  private func progressView() -> some View {
    ProgressView("Загрузка вопроса...")
  }
}


