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
            VStack(spacing:UIScreen.main.bounds.height/60) {
                    if isShowResult {
                            ResultView()
                            .modifier(FrameFitToDevices(iPhone: (width: nil, height: 400),
                                                        iPhoneSE: (width: nil, height: 350),
                                                        iPad: (width: nil, height: 800)))
                        if gameViewModel.game.nowGameCount < gameViewModel.game.maxGameCount {
                            Button("次のゲームへ") {
                                gameViewModel.continueGame()
                                realmViewModel.updateGame(primaryKey: 0, updatedGame: gameViewModel.game)
                                rootViewModel.nextGameView(nextView: .discussionView)
                            }
                            .modifier(TextFitToDevices(iPhone: 30, iPhoneSE: 25, iPad: 50))
                            .fontWeight(.black)
                            .foregroundColor(Color.white)
                            .modifier(FrameFitToDevices(iPhone: (width: 300, height: 50),
                                                        iPhoneSE: (width: 230, height: 40),
                                                        iPad: (width: 600, height: 100)))
                            .background(Color.mint)
                            .cornerRadius(10)
                            Button("ゲームを終了する") {
                                isShowResult = false
                                realmViewModel.deleteGame(primaryKey: 0)
                            }
                            .modifier(TextFitToDevices(iPhone: 30, iPhoneSE: 25, iPad: 50))
                            .fontWeight(.black)
                            .foregroundStyle(Color.mint)
                            .modifier(FrameFitToDevices(iPhone: (width: 300, height: 50),
                                                        iPhoneSE: (width: 230, height: 40),
                                                        iPad: (width: 600, height: 100)))
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.mint, lineWidth: 4)
                            )
                            Spacer()
                        } else {
                            Button {
                                isShowResult = false
                            } label: {
                                Text("結果発表")
                                    .modifier(TextFitToDevices(iPhone: 30, iPhoneSE: 25, iPad: 50))
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.white)
                            }
                            .modifier(FrameFitToDevices(iPhone: (width: 300, height: 50),
                                                        iPhoneSE: (width: 230, height: 40),
                                                        iPad: (width: 600, height: 100)))
                            .background(Color.yellow)
                            .cornerRadius(10)
                            .onAppear(){
                                realmViewModel.deleteGame(primaryKey: 0)
                            }
                        }
                        Spacer()
                    } else {
                        WinnerView(winnerUser: gameViewModel.winnerUser())
                            .modifier(FrameFitToDevices(iPhone: (width: nil, height: 400),
                                                        iPhoneSE: (width: nil, height: 350),
                                                        iPad: (width: nil, height: 800)))
                        Button("ホーム"){
                            gameViewModel.resetGame()
                            rootViewModel.nextEditView(nextView: .startGameView)
                            isShowResult = true
                        }
                        .modifier(TextFitToDevices(iPhone: 30, iPhoneSE: 25, iPad: 50))
                        .fontWeight(.black)
                        .foregroundColor(.yellow)
                        .modifier(FrameFitToDevices(iPhone: (width: 300, height: 50),
                                                    iPhoneSE: (width: 230, height: 40),
                                                    iPad: (width: 600, height: 100)))
                        .background(.yellow.opacity(0.2))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.yellow, lineWidth: 3)
                        )
                        Spacer()
                    }
            }
        }
    }
}

#Preview {
    ResultGameView()
        .environmentObject(RootViewModel())
        .environmentObject(GameViewModel())
        .environmentObject(RealmViewModel())
}
