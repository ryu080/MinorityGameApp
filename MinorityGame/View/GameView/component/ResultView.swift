//
//  ResultView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject private var rootViewModel:RootViewModel
    @EnvironmentObject private var gameViewModel:GameViewModel
    @EnvironmentObject private var questionViewModel:QuestionViewModel

    @State private var yesUsers:[User] = []
    @State private var noUsers:[User] = []

    var body: some View {
        ZStack {
            Color.pennBlue
            Group {
                if rootViewModel.loadingView {
                    VStack {
                        Spacer()
                        List {
                            Section {
                                ForEach(yesUsers) { user in
                                    HStack {
                                        Text(user.name)
                                            .font(.title3)
                                            .fontWeight(.black)
                                            .foregroundStyle(Color.pennBlue)
                                        Spacer()
                                        Text("合計\(user.totalPoints)P")
                                            .font(.title3)
                                            .fontWeight(.black)
                                            .foregroundStyle(Color.pennBlue)
                                    }
                                    .padding(10)
                                    .listRowBackground(Color.champagne)
                                }
                            }header: {
                                HStack{
                                    Text(questionViewModel.question!.choice1)
                                        .font(.title)
                                        .fontWeight(.black)
                                        .foregroundStyle(Color.electricBlue)
                                    Text("\(yesUsers.count)人")
                                        .font(.title)
                                        .fontWeight(.black)
                                        .foregroundStyle(Color.champagne)
                                    Spacer()
                                    Text(gameViewModel.userPoint(point: yesUsers.first?.point ?? 1))
                                        .font(.title)
                                        .fontWeight(.black)
                                        .foregroundStyle(Color.green)

                                    Spacer()
                                }
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .frame(height: UIScreen.main.bounds.height/4)
                        List {
                            Section {
                                ForEach(noUsers) { user in
                                    HStack {
                                        Text(user.name)
                                            .font(.title3)
                                            .fontWeight(.black)
                                            .foregroundStyle(Color.pennBlue)
                                        Spacer()
                                        Text("合計\(user.totalPoints)P")
                                            .font(.title3)
                                            .fontWeight(.black)
                                            .foregroundStyle(Color.pennBlue)
                                    }
                                    .padding(10)
                                    .listRowBackground(Color.champagne)
                                }
                            }header: {
                                HStack {
                                    Text(questionViewModel.question!.choice2)
                                        .font(.title)
                                        .fontWeight(.black)
                                        .foregroundStyle(Color.bittersweet)
                                    Text("\(noUsers.count)人")
                                        .font(.title)
                                        .fontWeight(.black)
                                        .foregroundStyle(Color.champagne)
                                    Spacer()
                                    Text(gameViewModel.userPoint(point: noUsers.first?.point ?? 1))
                                        .font(.title)
                                        .fontWeight(.black)
                                        .foregroundStyle(Color.green)

                                    Spacer()
                                }
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .frame(height: UIScreen.main.bounds.height/4)
                        Spacer()
                    }
                } else {
                    ProgressView()
                        .onAppear() {
                            self.yesUsers = gameViewModel.yesUser()
                            self.noUsers = gameViewModel.noUser()
                            rootViewModel.loadingView = true
                        }
                }
            }
        }
    }
}

#Preview {
    ResultView()
        .environmentObject(RootViewModel())
        .environmentObject(GameViewModel())
        .environmentObject(QuestionViewModel())
}
