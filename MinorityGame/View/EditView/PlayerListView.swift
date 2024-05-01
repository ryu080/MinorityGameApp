//
//  CreatePlayerView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/28.
//

import SwiftUI

struct PlayerListView: View {
    @EnvironmentObject private var gameViewModel:GameViewModel
    @EnvironmentObject private var alertViewModel:AlertViewModel
    @EnvironmentObject private var rootViewModel:RootViewModel

    @State var isShowCreatePlayerView:Bool = false
    @State var isShowGameCountView:Bool = false

    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0, alignment: .center), count: 4)

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    VStack {
                        Spacer()
                        Text("問題数")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        HStack {
                            Spacer()
                            Button {
                                gameViewModel.gameCountDown()
                            } label: {
                                Image(systemName: "minus")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 40,height: 40)
                            .background(.mint.opacity(0.8))
                            .clipShape(Circle())                        .overlay(
                                Circle()
                                    .stroke(Color.mint, lineWidth: 3)
                            )
                            Spacer()
                            Text("\(gameViewModel.game.maxGameCount)")
                                .font(.system(size: 75))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            Spacer()
                            Button {
                                gameViewModel.gameCountUp()
                            } label: {
                                Image(systemName: "plus")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 40,height: 40)
                            .background(.mint.opacity(0.8))
                            .clipShape(Circle())                        .overlay(
                                Circle()
                                    .stroke(Color.mint, lineWidth: 3)
                            )
                            Spacer()
                        }
                        Spacer()
                    }
                }
                Spacer()
                ZStack{
                    Rectangle()
                        .frame(height:UIScreen.main.bounds.height/1.5)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    VStack {
                        Spacer()
                        Button  {
                            isShowCreatePlayerView.toggle()
                        } label: {
                            Text("プレイヤー追加")
                                .font(.title2)
                                .fontWeight(.bold)
                                .tint(.white)
                        }
                        .frame(width: 300,height: 50)
                        .background(.mint.opacity(0.8))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.mint, lineWidth: 3)
                        )
                        .padding(10)
                        Spacer()
                        ScrollView( .vertical) {
                            Spacer()
                            LazyVGrid(columns:columns) {
                                ForEach(gameViewModel.game.users){user in
                                    PlayerView(playerImageData:user.imageData, name: user.name).padding(8)                                }
                            }
                            .padding()
                            .background(.gray.opacity(0.2))
                            .cornerRadius(10)
                            Spacer()
                            Button {
                                gameViewModel.limitUserCount(root: rootViewModel, alert: alertViewModel)
                            } label: {
                                Text("ゲームスタート")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .tint(.white)
                            }
                            .frame(width: 200,height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(10)
                            .padding()
                            Spacer()
                        }.frame(width: UIScreen.main.bounds.width-20)
                    }
                }
            }
            .sheet(isPresented: $isShowCreatePlayerView, content: {
                CreatePlayerView()
            })
            .alert(alertViewModel.alertTitle, isPresented: $alertViewModel.isShowAlert) {
            } message: {
                Text(alertViewModel.alertMessage)
            }
            .edgesIgnoringSafeArea(.all)

        }
    }
}

#Preview {
    PlayerListView()
        .environmentObject(GameViewModel())
        .environmentObject(AlertViewModel())
        .environmentObject(RootViewModel())
}
