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

    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0, alignment: .center), count: 4)

    var body: some View {
        ZStack {
            Color.clear
                .edgesIgnoringSafeArea(.all)
            Group {
                if rootViewModel.loadingView {
                    VStack {
                        Spacer()
                        VStack{
                            HStack {
                                Text(questionViewModel.question?.choice1 ?? "北海道")
                                    .font(.title)
                                    .fontWeight(.black)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal,10)
                                Text("\(yesUsers.count)人")
                                    .font(.title)
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.white)
                                Spacer()
                                if gameViewModel.userPoint(users: yesUsers){
                                    Text("+1")
                                        .font(.title)
                                        .fontWeight(.black)
                                        .foregroundStyle(Color.white)
                                        .frame(width: 100,height: 50)
                                        .background(.yellow)
                                }
                            }
                            .frame(height: 50)
                            .background(Color.electricBlue)
                            .cornerRadius(10)

                            ScrollView( .vertical) {
                                Spacer()
                                LazyVGrid(columns:columns) {
                                    ForEach(yesUsers){user in
                                        VStack{
                                            PlayerView(playerImageData:user.imageData, name: user.name, backgroundColor: Color.electricBlue,opacity: 1)
                                            Text("\(user.totalPoints)")
                                                .fontWeight(.black)
                                                .foregroundStyle(.white)
                                                .frame(width: 80)
                                                .background(.yellow)
                                                .cornerRadius(10)
                                                .padding(5)
                                        }
                                    }
                                }
                                .padding()
                                .background(.white.opacity(0.8))
                                .cornerRadius(10)
                            }
                        }.frame(width: UIScreen.main.bounds.width-20,height: UIScreen.main.bounds.height/3)
                        VStack{
                            HStack {
                                Text(questionViewModel.question?.choice2 ?? "沖縄県")
                                    .font(.title)
                                    .fontWeight(.black)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal,10)
                                Text("\(noUsers.count)人")
                                    .font(.title)
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.white)
                                Spacer()
                                if gameViewModel.userPoint(users: noUsers){
                                    Text("+1")
                                        .font(.title)
                                        .fontWeight(.black)
                                        .foregroundStyle(Color.white)
                                        .frame(width: 100,height: 50)
                                        .background(.yellow)
                                }
                            }
                            .frame(height: 50)
                            .background(Color.bittersweet)
                            .cornerRadius(10)
                            ScrollView( .vertical) {
                                Spacer()
                                LazyVGrid(columns:columns) {
                                    ForEach(noUsers){user in
                                        VStack{
                                            PlayerView(playerImageData:user.imageData, name: user.name, backgroundColor: Color.bittersweet,opacity: 1)
                                            Text("\(user.totalPoints)")
                                                .fontWeight(.black)
                                                .foregroundStyle(.white)
                                                .frame(width: 80)
                                                .background(.yellow)
                                                .cornerRadius(10)
                                                .padding(5)
                                        }
                                    }
                                }
                                .padding()
                                .background(.white.opacity(0.8))
                                .cornerRadius(10)
                            }
                        }.frame(width: UIScreen.main.bounds.width-20,height: UIScreen.main.bounds.height/3)
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
