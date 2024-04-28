//
//  CreatePlayerView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/28.
//

import SwiftUI

struct PlayerListView: View {
    @EnvironmentObject private var gameViewModel:GameViewModel

    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0, alignment: .center), count: 4)
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    Spacer()
                    Text("\(gameViewModel.game.users.count)")
                        .font(.system(size: 80))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.top,50)
                    Spacer()
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
                                    PlayerView(playerImage: Image(systemName: "person"), name: user.name)
                                }
                            }
                            .padding()
                            .background(.gray.opacity(0.2))
                            .cornerRadius(10)
                            Spacer()
                            Button {

                            } label: {
                                Text("次へ")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .tint(.white)
                            }
                            .frame(width: 150,height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(10)
                            .padding()
                            Spacer()
                        }.frame(width: UIScreen.main.bounds.width-20)
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    PlayerListView()
        .environmentObject(GameViewModel())
}
