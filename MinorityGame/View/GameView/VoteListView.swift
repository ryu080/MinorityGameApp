//
//  VoteListView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct VoteListView: View {
    @EnvironmentObject private var rootViewModel:RootViewModel
    @EnvironmentObject private var gameViewModel:GameViewModel
    @EnvironmentObject private var realmViewModel:RealmViewModel
    @EnvironmentObject private var questionViewModel:QuestionViewModel
    @EnvironmentObject private var alertViewModel:AlertViewModel

    @State private var isShowVoteView:Bool = false
    @State var voteUser:User = User(id: 0, imageData: nil, name: "", point: 0, totalPoints: 0, question: 0)
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0, alignment: .center), count: 4)

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                VStack{
                    Spacer()
                    VStack{
                        Spacer()
                        Text(questionViewModel.question?.text ?? "旅行に行くならどっち？")
                            .modifier(TextFitToDevices(iPhone: 28, iPhoneSE: 23, iPad: 40))
                            .bold()
                            .foregroundStyle(Color.white)
                            .modifier(FrameFitToDevices(iPhone: (width: 350, height: 150),
                                                        iPhoneSE: (width: 320, height: 130),
                                                        iPad: (width: 800, height: 250)))
                            .background(LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(20)
                            .overlay() {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.mint, lineWidth: 3)
                            }
                        Spacer()
                        HStack {
                            Text(questionViewModel.question?.choice1 ?? "北海道")
                                .modifier(TextFitToDevices(iPhone: 25, iPhoneSE: 20, iPad: 35))
                                .bold()
                                .foregroundStyle(Color.electricBlue)
                                .modifier(FrameFitToDevices(iPhone: (width: 160, height: 50),
                                                            iPhoneSE: (width: 140, height: 40),
                                                            iPad: (width: 300, height: 90)))
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay() {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 3)
                                }
                            Spacer()
                            Text(questionViewModel.question?.choice2 ?? "沖縄県")
                                .modifier(TextFitToDevices(iPhone: 25, iPhoneSE: 20, iPad: 35))
                                .bold()
                                .foregroundStyle(Color.bittersweet)
                                .modifier(FrameFitToDevices(iPhone: (width: 160, height: 50),
                                                            iPhoneSE: (width: 140, height: 40),
                                                            iPad: (width: 300, height: 90)))
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay() {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 3)
                                }
                        }
                        Spacer()
                    }.modifier(FrameFitToDevices(iPhone: (width: 350, height: 250),
                                                 iPhoneSE: (width: 320, height: 200),
                                                 iPad: (width: 800, height: 400)))
                    Spacer()
                }.modifier(FrameFitToDevices(iPhone: (width: 350, height: UIScreen.main.bounds.height-600),
                                             iPhoneSE: (width: 320, height: UIScreen.main.bounds.height-430),
                                             iPad: (width: 800, height: UIScreen.main.bounds.height-900)))
                ZStack {
                    RoundedCorners(color: .white, tl: 50, tr: 50, bl: 0, br: 0)
                        .compositingGroup()
                        .shadow(radius: 5)
                    VStack {
                        VStack {
                            Spacer()
                            Text("投票するプレイヤーを選んでください")
                                .modifier(TextFitToDevices(iPhone: 20, iPhoneSE: 18, iPad: 50))
                                .fontWeight(.black)
                            Spacer()
                            ScrollView( .vertical) {
                                Spacer()
                                LazyVGrid(columns:columns) {
                                    ForEach(gameViewModel.game.users){user in
                                        if user.question == 0{
                                            Button{
                                                voteUser = user
                                                isShowVoteView.toggle()
                                            }label: {
                                                PlayerView(playerImageData:user.imageData, name: user.name, backgroundColor: .mint,opacity: 0.3)
                                                    .padding()
                                            }
                                        }else{
                                            PlayerView(playerImageData:user.imageData, name: user.name, backgroundColor:.gray,opacity: 0.3)
                                                .padding()
                                        }
                                    }
                                }
                                .padding()
                                .background(.gray.opacity(0.2))
                                .cornerRadius(10)
                            }
                            .modifier(FrameFitToDevices(iPhone: (width: 350, height: 220),
                                                        iPhoneSE: (width: 350, height: 180),
                                                        iPad: (width: 800, height: 300)))
                            Spacer()
                            if gameViewModel.voteComplete(){
                                Button {
                                    rootViewModel.nextGameView(nextView: .resultAnnouncementView)
                                } label: {
                                    Text("結果へ進む")
                                        .modifier(TextFitToDevices(iPhone: 25, iPhoneSE: 20, iPad: 50))
                                        .fontWeight(.black)
                                        .foregroundStyle(Color.white)
                                }
                                .modifier(FrameFitToDevices(iPhone: (width: 300, height: 50),
                                                            iPhoneSE: (width: 230, height: 40),
                                                            iPad: (width: 600, height: 100)))
                                .background(.mint.opacity(0.8))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.mint, lineWidth: 3)
                                )
                            }else {
                                Text("結果へ進む")
                                    .modifier(TextFitToDevices(iPhone: 25, iPhoneSE: 20, iPad: 50))
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.white)
                                    .modifier(FrameFitToDevices(iPhone: (width: 300, height: 50),
                                                                iPhoneSE: (width: 230, height: 40),
                                                                iPad: (width: 600, height: 100)))
                                    .background(.gray.opacity(0.8))
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 3)
                                    )
                            }

                            Spacer()
                        }
                        .modifier(FrameFitToDevices(iPhone: (width: nil, height: 480),
                                                    iPhoneSE: (width: nil, height: 350),
                                                    iPad: (width: nil, height: 700)))
                        Spacer()
                    }.modifier(FrameFitToDevices(iPhone: (width: nil, height: 550),
                                                 iPhoneSE: (width: nil, height: 400),
                                                 iPad: (width: nil, height: 800)))
                }
                .modifier(FrameFitToDevices(iPhone: (width: nil, height: 550),
                                            iPhoneSE: (width: nil, height: 400),
                                            iPad: (width: nil, height: 800)))
            }
            .edgesIgnoringSafeArea(.all)
        }
        .sheet(isPresented: $isShowVoteView){
            VoteView(user: $voteUser)
        }
    }
}

#Preview {
    VoteListView()
        .environmentObject(RootViewModel())
        .environmentObject(GameViewModel())
        .environmentObject(RealmViewModel())
        .environmentObject(AlertViewModel())
        .environmentObject(QuestionViewModel())
}
