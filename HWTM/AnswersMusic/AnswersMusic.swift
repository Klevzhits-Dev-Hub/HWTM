//
//  AnswersMusic.swift
//  HWTM
//
//  Created by Игорь Клевжиц on 25.07.2025.
//

import AVFoundation

final class AnswersMusic {
    
    static let shared = AnswersMusic()
    
    private var intrigaPlayer: AVAudioPlayer?
    private var answerPlayer: AVAudioPlayer?
    
    func correctAnswerPlay() {
        playIntriga {
            self.playAnswer(named: "correct")
        }
    }
    
    func wrongAnswerPlay() {
        playIntriga {
            self.playAnswer(named: "wrong")
        }
    }
    
    func stopMusic() {
        intrigaPlayer?.stop()
        answerPlayer?.stop()
    }
    
    private func playIntriga(completion: @escaping () -> Void) {
        guard let url = Bundle.main.url(forResource: "intriga", withExtension: "mp3") else { return }
        do {
            intrigaPlayer = try AVAudioPlayer(contentsOf: url)
            intrigaPlayer?.play()
        } catch {
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.intrigaPlayer?.stop()
            completion()
        }
    }
    
    private func playAnswer(named name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            return
        }
        do {
            answerPlayer = try AVAudioPlayer(contentsOf: url)
            answerPlayer?.play()
        } catch {
            return
        }
    }
}
