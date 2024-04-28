//
//  StartGameView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct StartGameView: View {
    @EnvironmentObject private var rootViewModel:RootViewModel
    @EnvironmentObject private var gameViewModel:GameViewModel
    @EnvironmentObject private var realmViewModel:RealmViewModel
    @EnvironmentObject private var questionViewModel:QuestionViewModel

    var body: some View {
            ZStack {
                Color.pennBlue
                    .edgesIgnoringSafeArea(.all)
                Group {
                    if questionViewModel.isShowProgress == nil{
                        BlurView(text: "問題文取得中...", textSize: 30, startTime: 1)
                            .onAppear(){
                                Task{
                                    await
                                    questionViewModel.setQuestionsRealm(realm: realmViewModel)
                                }
                            }
                    } else if questionViewModel.isShowProgress == true {
                        VStack {
                            Text("最新のデータ修得に失敗しました。")
                                .font(.title2)
                                .foregroundStyle(Color.electricBlue)
                            Button {
                                questionViewModel.isShowProgress = false
                            } label: {
                                Text("オフラインでゲームを始める")
                            }
                            Button {
                                questionViewModel.isShowProgress = nil
                                Task{
                                    await questionViewModel.setQuestionsRealm(realm: realmViewModel)
                                }
                            } label: {
                                Text("もう一度最新データに更新する")
                            }
                        }
                    } else {
                        VStack {
                            Spacer()
                            Text("少数派ゲーム")
                                .font(.largeTitle)
                                .fontWeight(.black)
                                .foregroundStyle(Color.champagne)
                            Spacer()
                            VStack(spacing:15){
                                Button {
                                    realmViewModel.deleteGame(id: 0)
                                    rootViewModel.nextEditView(nextView: .editGameView)
                                } label: {
                                    Text("新規ゲームを始める")
                                        .font(.title)
                                        .fontWeight(.black)
                                        .foregroundStyle(Color.pennBlue)
                                }
                                .padding(10)
                                .background(Color.champagne)
                                .cornerRadius(10)
                                if realmViewModel.readGame(id: 0) != nil {
                                    Button {
                                        gameViewModel.game = realmViewModel.readGame(id: 0)!
                                        gameViewModel.continueGame()
                                        rootViewModel.nextGameView(nextView: .discussionView)
                                    } label: {
                                        Text("続きから再開する")
                                            .font(.title)
                                            .fontWeight(.black)
                                            .foregroundStyle(Color.champagne)
                                    }
                                    .padding(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.champagne, lineWidth: 4)
                                    )
                                }
                                Button {

                                } label: {
                                    Text("問題文を作成する")
                                        .font(.title2)
                                        .fontWeight(.black)
                                        .foregroundStyle(Color.champagne)
                                }
                                .padding(10)
                                .background(Color.green)
                                .cornerRadius(10)
                            }
                            Spacer()
                        }
                    }
            }
        }
    }
}

#Preview {
    StartGameView()
        .environmentObject(RootViewModel())
        .environmentObject(GameViewModel())
        .environmentObject(RealmViewModel())
        .environmentObject(QuestionViewModel())
}
