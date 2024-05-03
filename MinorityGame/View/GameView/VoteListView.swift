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

    @State private var isShowVoteView:Bool = true
    @State var voteUser:User?
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0, alignment: .center), count: 4)

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Text(questionViewModel.question?.text ?? "旅行に行くならどっち？")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.white)
                    .frame(width: UIScreen.main.bounds.width-20, height:150)
                    .background(LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(20)
                    .overlay() {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.mint, lineWidth: 3)
                    }
                HStack {
                    Text(questionViewModel.question?.choice1 ?? "北海道")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white)
                    .frame(width: 160,height: 50)
                    .background(Color.electricBlue)
                    .cornerRadius(10)
                    .overlay() {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.electricBlue, lineWidth: 3)
                    }
                    Spacer()
                    Text(questionViewModel.question?.choice2 ?? "沖縄県")
                        .font(.title2)
                    .bold()
                    .foregroundStyle(.white)
                    .frame(width: 160, height: 50)
                    .background(Color.bittersweet)
                    .cornerRadius(10)
                    .overlay() {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.bittersweet, lineWidth: 3)
                    }
                }.frame(width: UIScreen.main.bounds.width-20,height: 100)

                ZStack {
                    RoundedCorners(color: .white, tl: 20, tr: 20, bl: 0, br: 0)
                    VStack {
                        Text("投票するプレイヤーを選んでください")
                            .font(.title2)
                            .fontWeight(.black)
                            .padding(.vertical,20)
                        ScrollView( .vertical) {
                            Spacer()
                            LazyVGrid(columns:columns) {
                                ForEach(gameViewModel.game.users){user in
                                    if user.question == 0{
                                        Button{
                                            voteUser = user
                                            isShowVoteView.toggle()
                                        }label: {
                                            PlayerView(playerImageData:user.imageData, name: user.name, backgroundColor: .mint,opacity: 0.3).padding(8)
                                        }
                                    }else{
                                        PlayerView(playerImageData:user.imageData, name: user.name, backgroundColor:.gray,opacity: 0.3).padding(8)
                                    }
                                }
                            }
                            .padding()
                            .background(.gray.opacity(0.2))
                            .cornerRadius(10)
                            if gameViewModel.voteComplete(){
                                Button {
                                    rootViewModel.nextGameView(nextView: .resultAnnouncementView)
                                } label: {
                                    Text("結果へ進む")
                                        .font(.title)
                                        .fontWeight(.black)
                                        .foregroundStyle(Color.white)
                                }
                                .frame(width: 300,height: 50)
                                .background(.mint.opacity(0.8))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.mint, lineWidth: 3)
                                )
                                .padding(30)
                            }else {
                                Text("結果へ進む")
                                    .font(.title)
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.white)
                                    .frame(width: 300,height: 50)
                                    .background(.gray.opacity(0.8))
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 3)
                                    )
                                    .padding(30)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width-20)
                        Spacer()
                    }
                    .frame(height:UIScreen.main.bounds.height/1.9)
                }
                .frame(height:UIScreen.main.bounds.height/1.9)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("投票")
                    .foregroundColor(Color.white)
                    .fontWeight(.black)
                    .font(.title2)
            }
        }
        .alert(alertViewModel.alertTitle, isPresented: $alertViewModel.isShowAlert) {
        } message: {
            Text(alertViewModel.alertMessage)
        }
        .sheet(isPresented: Binding(
            get: { isShowVoteView && voteUser != nil },
            set: { _ in isShowVoteView = false }         
        )) {
                VoteView(user: voteUser!)
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
