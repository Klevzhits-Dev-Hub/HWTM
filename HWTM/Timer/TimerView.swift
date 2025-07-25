//
//  TimerView.swift
//  HWTM
//
//  Created by Игорь Клевжиц on 25.07.2025.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timerController: TimerController
    
    var body: some View {
        Image(timerController.currntImageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
