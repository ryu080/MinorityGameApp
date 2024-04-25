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
    @State private var winer:String = ""

    var body: some View {
        ZStack {
            Color.pennBlue
            Group {
                if rootViewModel.loadingView {
                    VStack {
                        Spacer()
                        Text(winer)
                            .font(.largeTitle)
                            .frame(width: UIScreen.main.bounds.width,height: 50)
                            .fontWeight(.black)
                            .foregroundStyle(Color.pennBlue)
                            .background(Color.champagne)
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
//                                        if user.question == 1 {
//                                            Text("YES")
//                                                .font(.title3)
//                                                .fontWeight(.black)
//                                                .foregroundStyle(.blue)
//                                        } else if user.question == 2 {
//                                            Text("NO")
//                                                .font(.title3)
//                                                .fontWeight(.black)
//                                                .foregroundStyle(.red)
//                                        }
//                                        Text("\(user.point)")
//                                            .font(.title3)
//                                            .fontWeight(.black)
//                                            .foregroundStyle(Color.pennBlue)
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
                                        .foregroundStyle(.blue)
                                    Text("\(yesUsers.count)人")
                                        .font(.title)
                                        .fontWeight(.black)
                                        .foregroundStyle(Color.champagne)
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
//                                        if user.question == 1 {
//                                            Text("YES")
//                                                .font(.title3)
//                                                .fontWeight(.black)
//                                                .foregroundStyle(.blue)
//                                        } else if user.question == 2 {
//                                            Text("NO")
//                                                .font(.title3)
//                                                .fontWeight(.black)
//                                                .foregroundStyle(.red)
//                                        }
//                                        Text("\(user.point)")
//                                            .font(.title3)
//                                            .fontWeight(.black)
//                                            .foregroundStyle(Color.pennBlue)
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
                                        .foregroundStyle(.red)
                                    Text("\(noUsers.count)人")
                                        .font(.title)
                                        .fontWeight(.black)
                                        .foregroundStyle(Color.champagne)
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
                            self.winer = gameViewModel.resultVote()
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
