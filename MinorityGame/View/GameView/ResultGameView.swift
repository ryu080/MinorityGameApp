//
//  ResultGameView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct ResultGameView: View {
    @EnvironmentObject var gameViewModel:GameViewModel
    @EnvironmentObject var realmViewModel:RealmViewModel

    @State var isShowResultView:Bool = false

    var body: some View {
        ZStack{
            VStack{
                if isShowResultView {
                    ResultView()
                    if gameViewModel.game.nowGameCount < gameViewModel.game.maxGameCount {
                        Button("次のゲームへ"){
                            gameViewModel.continueGame()
                            realmViewModel.updateGame(id: 0, updatedGame: gameViewModel.game)
                            gameViewModel.gameView = .questionView
                        }
                    }
                    Button("ホーム"){
                        gameViewModel.resetGame()
                        gameViewModel.rootView = .editView
                        gameViewModel.gameView = .questionView
                    }
                }else{
                    Button("結果を見る"){
                        isShowResultView.toggle()
                        realmViewModel.updateGame(id: 0, updatedGame: gameViewModel.game)
                    }
                }
            }.padding(20)
        }
    }
}

#Preview {
    ResultGameView()
        .environmentObject(GameViewModel())
        .environmentObject(RealmViewModel())
}
