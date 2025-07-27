//
//  TimerController.swift
//  HWTM
//
//  Created by Игорь Клевжиц on 25.07.2025.
//

import AVFoundation
import SwiftUI

final class TimerController: ObservableObject {
    
    @Published var currntImageName = "30secs"
    
    private var timer: Timer?
    private var secondsRemaining = 30
    
    private var audioPlayer: AVAudioPlayer?
    
    var onTimeout: (() -> Void)?
    
    func start() {
        reset()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.tick()
        }
        playMusic()
    }
    
    func repause() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.tick()
        }
        repauseMusic()
    }
    
    func pause() {
        timer?.invalidate()
        pauseMusic()
    }
    
    func reset() {
        timer?.invalidate()
        secondsRemaining = 30
        updateImage()
        stopMusic()
    }
    
    private func tick() {
        guard secondsRemaining > 0 else {
            timer?.invalidate()
            onTimeout?()
            return
        }
        secondsRemaining -= 1
        updateImage()
    }
    
    private func updateImage() {
        currntImageName = "\(secondsRemaining)secs"
    }
    
    private func playMusic() {
        guard let url = Bundle.main.url(forResource: "tik-tak", withExtension: "mp3") else {
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            return
        }
    }
    
    private func stopMusic() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
    
    private func pauseMusic() {
        audioPlayer?.pause()
    }
    
    private func repauseMusic() {
        audioPlayer?.play()
    }
}
