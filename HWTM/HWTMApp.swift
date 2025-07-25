//
//  HWTMApp.swift
//  HWTM
//
//  Created by Игорь Клевжиц on 21.07.2025.
//

import SwiftUI

@main
struct HWTMApp: App {
    var body: some Scene {
        WindowGroup {
          NavigationStack {
            HomeContentView(vm: HomeVM(initialState: .notStarted))
          }
        }
    }
}
