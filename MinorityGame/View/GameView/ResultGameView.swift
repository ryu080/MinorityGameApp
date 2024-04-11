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
            Color.pennBlue
                .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                if isShowResultView == 1{
                    ResultView()
                    Spacer()
                    if gameViewModel.game.nowGameCount < gameViewModel.game.maxGameCount {
                        Button("次のゲームへ"){
                            gameViewModel.continueGame()
                            realmViewModel.updateGame(id: 0, updatedGame: gameViewModel.game)
                            gameViewModel.gameView = .questionView
                            isShowResultView = 0
                        }
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(Color.pennBlue)
                        .padding(10)
                        .background(Color.champagne)
                        .cornerRadius(10)
                        Button("ゲームを終了する"){
                            gameViewModel.resetGame()
                            realmViewModel.deleteGame(id: 0)
                            gameViewModel.rootView = .editView
                            gameViewModel.gameView = .questionView
                            isShowResultView = 0
                        }
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundStyle(Color.champagne)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.champagne, lineWidth: 4)
                        )
                        Spacer()
                    }else{
                        Button {
                            isShowResultView = 2
                        } label: {
                            Text("結果発表")
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundStyle(Color.pennBlue)
                        }
                        .padding(10)
                        .background(Color.champagne)
                        .cornerRadius(10)
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
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(Color.pennBlue)
                    .padding(10)
                    .background(Color.champagne)
                    .cornerRadius(10)

                }else{
                    ProgressView()
                        .frame(height: 300)
                        .scaleEffect(x: 10, y: 10, anchor: .center)
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.champagne))
                    ZStack{
                        Button("少数派は..."){
                            isShowResultView = 1
                            realmViewModel.updateGame(id: 0, updatedGame: gameViewModel.game)
                        }
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(Color.pennBlue)
                        .padding(10)
                        .background(Color.champagne)
                        .cornerRadius(10)
                    }
                }
                Spacer()
            }.padding(20)
        }
    }
}

#Preview {
    ResultGameView()
        .environmentObject(GameViewModel())
        .environmentObject(RealmViewModel())
}
