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
            if rootViewModel.loadingView {
                VStack {
                    VStack{
                        HStack {
                            Text(questionViewModel.question?.choice1 ?? "北海道")
                                .modifier(TextFitToDevices(iPhone: 23, iPhoneSE: 20, iPad: 50))
                                .fontWeight(.black)
                                .foregroundStyle(.white)
                                .padding(.horizontal,10)
                            Text("\(yesUsers.count)人")
                                .modifier(TextFitToDevices(iPhone: 23, iPhoneSE: 20, iPad: 50))
                                .fontWeight(.black)
                                .foregroundStyle(Color.white)
                            Spacer()
                            if gameViewModel.userPoint(users: yesUsers){
                                Text("+1")
                                    .modifier(TextFitToDevices(iPhone: 23, iPhoneSE: 20, iPad: 50))
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.white)
                                    .modifier(FrameFitToDevices(iPhone: (width: 100, height: 50),
                                                                iPhoneSE: (width: 90, height: 45),
                                                                iPad: (width: 150, height: 80)))
                                    .background(.yellow)
                            }
                        }
                        .modifier(FrameFitToDevices(iPhone: (width: nil, height: 50),
                                                    iPhoneSE: (width: nil, height: 45),
                                                    iPad: (width: nil, height: 80)))
                        .background(Color.electricBlue)
                        .cornerRadius(10)
                        ScrollView( .vertical) {
                            LazyVGrid(columns:columns) {
                                ForEach(yesUsers){user in
                                    VStack{
                                        PlayerView(playerImageData:user.imageData, name: user.name, backgroundColor: Color.electricBlue,opacity: 1)
                                            .padding(.vertical,10)
                                        Text("\(user.totalPoints)")
                                            .fontWeight(.black)
                                            .foregroundStyle(.white)
                                            .modifier(FrameFitToDevices(iPhone: (width: 69, height: nil),
                                                                        iPhoneSE: (width: 69, height: nil),
                                                                        iPad: (width: 120, height: nil)))
                                            .background(.yellow)
                                            .cornerRadius(10)
                                    }
                                }
                            }
                            .padding()
                            .background(.white.opacity(0.8))
                            .cornerRadius(10)
                        }
                    }.modifier(FrameFitToDevices(iPhone: (width: 350, height: 200),
                                                 iPhoneSE: (width: 320, height: 170),
                                                 iPad: (width: 800, height: 350)))
                    Spacer()
                    VStack{
                        HStack {
                            Text(questionViewModel.question?.choice2 ?? "沖縄県")
                                .modifier(TextFitToDevices(iPhone: 23, iPhoneSE: 20, iPad: 50))
                                .fontWeight(.black)
                                .foregroundStyle(.white)
                                .padding(.horizontal,10)
                            Text("\(noUsers.count)人")
                                .modifier(TextFitToDevices(iPhone: 23, iPhoneSE: 20, iPad: 50))
                                .fontWeight(.black)
                                .foregroundStyle(Color.white)
                            Spacer()
                            if gameViewModel.userPoint(users: noUsers){
                                Text("+1")
                                    .modifier(TextFitToDevices(iPhone: 23, iPhoneSE: 20, iPad: 50))
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.white)
                                    .modifier(FrameFitToDevices(iPhone: (width: 100, height: 50),
                                                                iPhoneSE: (width: 90, height: 45),
                                                                iPad: (width: 150, height: 80)))
                                    .background(.yellow)
                            }
                        }
                        .modifier(FrameFitToDevices(iPhone: (width: nil, height: 50),
                                                    iPhoneSE: (width: nil, height: 45),
                                                    iPad: (width: nil, height: 80)))
                        .background(Color.bittersweet)
                        .cornerRadius(10)
                        ScrollView( .vertical) {
                            LazyVGrid(columns:columns) {
                                ForEach(noUsers){user in
                                    VStack{
                                        PlayerView(playerImageData:user.imageData, name: user.name, backgroundColor: Color.bittersweet,opacity: 1)
                                            .padding(.vertical,10)
                                        Text("\(user.totalPoints)")
                                            .fontWeight(.black)
                                            .foregroundStyle(.white)
                                            .modifier(FrameFitToDevices(iPhone: (width: 69, height: nil),
                                                                        iPhoneSE: (width: 69, height: nil),
                                                                        iPad: (width: 120, height: nil)))
                                            .background(.yellow)
                                            .cornerRadius(10)
                                    }
                                }
                            }
                            .padding()
                            .background(.white.opacity(0.8))
                            .cornerRadius(10)
                        }
                    }.modifier(FrameFitToDevices(iPhone: (width: 350, height: 200),
                                                 iPhoneSE: (width: 320, height: 170),
                                                 iPad: (width: 800, height: 350)))
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

#Preview {
    ResultView()
        .environmentObject(RootViewModel())
        .environmentObject(GameViewModel())
        .environmentObject(QuestionViewModel())
}
