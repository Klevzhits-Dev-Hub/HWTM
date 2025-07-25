//
//  TimerController.swift
//  HWTM
//
//  Created by Игорь Клевжиц on 25.07.2025.
//

import SwiftUI

final class TimerController: ObservableObject {
    
    @Published var currntImageName = "30secs"
    
    private var timer: Timer?
    private var secondsRemaining = 30
    
    func start() {
        reset()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.tick()
        }
    }
    
    func repause() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.tick()
        }
    }
    
    func pause() {
        timer?.invalidate()
    }
    
    func reset() {
        timer?.invalidate()
        secondsRemaining = 30
        updateImage()
    }
    
    private func tick() {
        guard secondsRemaining > 0 else {
            timer?.invalidate()
            return
        }
        secondsRemaining -= 1
        updateImage()
    }
    
    private func updateImage() {
        currntImageName = "\(secondsRemaining)secs"
    }
}
