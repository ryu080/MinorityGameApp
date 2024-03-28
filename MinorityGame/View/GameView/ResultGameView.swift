//
//  ResultGameView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct ResultGameView: View {
    @EnvironmentObject var viewModel:GameViewModel
    @State var isShowResultView:Bool = false

    var body: some View {
        ZStack{
            VStack{
                if isShowResultView {
                    ResultView()
                    if viewModel.nowGameCount < viewModel.maxGameCount {
                        Button("次のゲームへ"){
                            viewModel.pageViewCount = 0
                            viewModel.continueGame()
                        }
                    }
                    Button("ホーム"){
                        viewModel.mainOrGameView = false
                        viewModel.pageViewCount = 0
                        viewModel.resetGame()
                    }
                }else{
                    Button("結果を見る"){
                        isShowResultView.toggle()
                    }
                }
            }.padding(20)
        }
    }
}

#Preview {
    ResultGameView()
        .environmentObject(GameViewModel())
}
