//
//  ResultGameView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct ResultGameView: View {
    @EnvironmentObject var rootViewModel:RootViewModel
    @EnvironmentObject var gameViewModel:GameViewModel
    @EnvironmentObject var realmViewModel:RealmViewModel

    @State private var isShowResult:Bool?

    var body: some View {
        ZStack{
            Color.pennBlue
                .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                if isShowResult == true {
                    ResultView()
                    Spacer()
                    if gameViewModel.game.nowGameCount < gameViewModel.game.maxGameCount {
                        Button("次のゲームへ"){
                            gameViewModel.continueGame()
                            realmViewModel.updateGame(id: 0, updatedGame: gameViewModel.game)
                            rootViewModel.gameView = .questionView
                            isShowResult = nil
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
                            rootViewModel.mainView = .editView
                            rootViewModel.gameView = .questionView
                            isShowResult = nil
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
                            isShowResult = false
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
                }else if isShowResult == false{
                    WinnerView(winnerUser: gameViewModel.winnerUser())
                    Button("ホーム"){
                        gameViewModel.resetGame()
                        realmViewModel.deleteGame(id: 0)
                        rootViewModel.mainView = .editView
                        rootViewModel.gameView = .questionView
                        isShowResult = nil
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
                            isShowResult = true
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
        .environmentObject(RootViewModel())
        .environmentObject(GameViewModel())
        .environmentObject(RealmViewModel())
}
