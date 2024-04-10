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

    @State var isShowResultView:Int = 0

    var body: some View {
        ZStack{
            VStack{
                if isShowResultView == 1{
                    ResultView()
                    if gameViewModel.game.nowGameCount < gameViewModel.game.maxGameCount {
                        Button("次のゲームへ"){
                            gameViewModel.continueGame()
                            realmViewModel.updateGame(id: 0, updatedGame: gameViewModel.game)
                            gameViewModel.gameView = .questionView
                            isShowResultView = 0
                        }
                        Button("ホーム"){
                            gameViewModel.resetGame()
                            realmViewModel.deleteGame(id: 0)
                            gameViewModel.rootView = .editView
                            gameViewModel.gameView = .questionView
                            isShowResultView = 0
                        }

                    }else{
                        Button {
                            isShowResultView = 2
                        } label: {
                            Text("結果発表")
                        }

                    }
                }else if isShowResultView == 2{
                    WinnerView(winnerUser: gameViewModel.winnerUser())
                    Button("ホーム"){
                        gameViewModel.resetGame()
                        realmViewModel.deleteGame(id: 0)
                        gameViewModel.rootView = .editView
                        gameViewModel.gameView = .questionView
                        isShowResultView = 0
                    }
                }else{
                    Button("少数派は..."){
                        isShowResultView = 1
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
