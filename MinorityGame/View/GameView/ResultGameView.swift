//
//  ResultGameView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct ResultGameView: View {
    @EnvironmentObject private var rootViewModel:RootViewModel
    @EnvironmentObject private var gameViewModel:GameViewModel
    @EnvironmentObject private var realmViewModel:RealmViewModel

    @State private var isShowResult:Bool = true
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Group {
                    if isShowResult {
                        ResultView()
                        Spacer()
                        if gameViewModel.game.nowGameCount < gameViewModel.game.maxGameCount {
                            Button("次のゲームへ") {
                                gameViewModel.continueGame()
                                realmViewModel.updateGame(id: 0, updatedGame: gameViewModel.game)
                                rootViewModel.nextGameView(nextView: .discussionView)
                            }
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(Color.white)
                            .padding(10)
                            .background(Color.green)
                            .cornerRadius(10)
                            Button("ゲームを終了する") {
                                isShowResult = false
                            }
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundStyle(Color.green)
                            .padding(10)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.green, lineWidth: 4)
                            )
                            Spacer()
                        } else {
                            Button {
                                isShowResult = false
                            } label: {
                                Text("結果発表")
                                    .font(.title)
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.white)
                            }
                            .padding(10)
                            .background(Color.yellow)
                            .cornerRadius(10)
                        }
                    } else {
                        WinnerView(winnerUser: gameViewModel.winnerUser())
                            .cornerRadius(20)
                        Button("ホーム"){
                            gameViewModel.resetGame()
                            realmViewModel.deleteGame(id: 0)
                            rootViewModel.nextEditView(nextView: .startGameView)
                            isShowResult = true
                        }
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(Color.white)
                        .padding(10)
                        .background(Color.green)
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
