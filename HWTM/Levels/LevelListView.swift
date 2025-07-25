//
//  LevelListView.swift
//  HWTM
//
//  Created by Дарья on 22.07.2025.
//

import SwiftUI

struct LevelListView: View {
    @StateObject var viewModel: LevelListViewModel
    
    var body: some View {
        ZStack {
            GradientBackground()
            VStack {
                
                HStack(alignment: .top) {
                    Button {
                        // делать назад в игру?
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Button {
                        // выйти из игры сразу или показать алерт?
                    } label: {
                        // скачать картинку с фигмы!!!!!!!
                        Image(systemName: "banknote")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                
                Spacer()
                
                ScrollViewReader { proxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            ForEach(viewModel.levels) { level in
                                LevelView(level: level, isCurrent: level.number == viewModel.currentLevel)
                                    .id(level.number)
                            }
                        }
                        .padding(.top, 40)
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 60)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            proxy.scrollTo(viewModel.levels.last?.number, anchor: .bottom)
                        }
                    }
                }
            }
            
            VStack {
                Image("miniLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100)
                    .padding(.top, 30)
                    .shadow(radius: 10)
                
                Spacer()
            }
            
        }
        
        
    }
}


#Preview {
    let previewLevels = [
        //        Level(number: 348, amount: "$44", type: .regular),
        //        Level(number: 3255, amount: "$04004", type: .regular),
        Level(number: 15, amount: "$1,000,000", type: .final),
        Level(number: 14, amount: "$500,000", type: .regular),
        Level(number: 13, amount: "$250,000", type: .regular),
        Level(number: 12, amount: "$100,000", type: .regular),
        Level(number: 11, amount: "$50,000", type: .regular),
        Level(number: 10, amount: "$25,000", type: .guaranteed),
        Level(number: 9, amount: "$15,000", type: .regular),
        Level(number: 8, amount: "$12,500", type: .regular),
        Level(number: 7, amount: "$10,000", type: .regular),
        Level(number: 6, amount: "$7,500", type: .regular),
        Level(number: 5, amount: "$5,000", type: .guaranteed),
        Level(number: 4, amount: "$3,000", type: .regular),
        Level(number: 3, amount: "$2,000", type: .regular),
        Level(number: 2, amount: "$1,000", type: .regular),
        Level(number: 1, amount: "$500", type: .regular)
    ]
    
    let previewVM = LevelListViewModel(levels: previewLevels)
    
    return LevelListView(viewModel: previewVM)
}

