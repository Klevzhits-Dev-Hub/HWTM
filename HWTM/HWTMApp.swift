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
            LevelListView(
                viewModel: LevelListViewModel(
                    levels: [
                        Level(number: 4, amount: "$3,000", type: .final),
                        Level(number: 3, amount: "$2,000", type: .regular),
                        Level(number: 2, amount: "$1,000", type: .guaranteed),
                        Level(number: 1, amount: "$500", type: .final)
                    ]
                )
            )
        }
    }
}
