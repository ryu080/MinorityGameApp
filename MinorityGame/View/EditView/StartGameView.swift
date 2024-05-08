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
                LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                Group {
                    if questionViewModel.isShowProgress == nil{
                        BlurView(text: "問題文取得中...", textSize: 30, startTime: 1)
                            .onAppear(){
                                Task{
                                    await
                                    questionViewModel.setAllQuestionsRealm(realm: realmViewModel)
                                }
                            }
                    } else if questionViewModel.isShowProgress == true {
                        VStack {
                            Text("最新のデータ修得に失敗しました。")
                                .font(.title2)
                                .foregroundStyle(Color.white)
                            Button {
                                questionViewModel.isShowProgress = false
                            } label: {
                                Text("オフラインでゲームを始める")
                                    .foregroundStyle(.white)
                            }
                            Button {
                                questionViewModel.isShowProgress = nil
                                Task{
                                    await questionViewModel.setAllQuestionsRealm(realm: realmViewModel)
                                }
                            } label: {
                                Text("もう一度最新データに更新する")
                                    .foregroundStyle(.white)
                            }
                        }
                    } else {
                        VStack {
                            Spacer()
                            Text("Unique")
                                .modifier(TextFitToDevices(iPhone: 80, iPhoneSE: 70, iPad: 120))
                                .fontWeight(.black)
                                .foregroundStyle(Color.white)
                            Text("ONE")
                                .modifier(TextFitToDevices(iPhone: 140, iPhoneSE: 120, iPad: 200))
                                .fontWeight(.black)
                                .foregroundStyle(Color.white)
                            Spacer()
                            VStack(spacing:20){
                                Button {
                                    realmViewModel.deleteGame(primaryKey: 0)
                                    gameViewModel.setPreviousUsers(realm: realmViewModel)
                                    rootViewModel.nextEditView(nextView: .playerListView)
                                } label: {
                                    Text("新規ゲームを始める")
                                        .modifier(TextFitToDevices(iPhone: 30, iPhoneSE: 25, iPad: 50))
                                        .fontWeight(.black)
                                        .foregroundStyle(Color.white)
                                }
                                .padding(10)
                                .background(Color.mint.opacity(0.8))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.mint, lineWidth: 3)
                                )
                                if realmViewModel.readGame(primaryKey: 0)?.users != nil {
                                    Button {
                                        gameViewModel.game = realmViewModel.readGame(primaryKey: 0)!
                                        gameViewModel.continueGame()
                                        rootViewModel.nextGameView(nextView: .discussionView)
                                    } label: {
                                        Text("続きから再開する")
                                            .modifier(TextFitToDevices(iPhone: 30, iPhoneSE: 25, iPad: 50))
                                            .fontWeight(.black)
                                            .foregroundStyle(Color.white)
                                    }
                                    .padding(10)
                                    .background(Color.blue.opacity(0.7))
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.blue, lineWidth: 3)
                                    )
                                }
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
