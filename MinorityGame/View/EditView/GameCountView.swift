//
//  GameCountView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/30.
//

import SwiftUI

struct GameCountView: View {
    @EnvironmentObject private var gameViewModel:GameViewModel
    @EnvironmentObject private var rootViewModel:RootViewModel
    var body: some View {
        ZStack{
            Color.gray.opacity(0.9)
                .edgesIgnoringSafeArea(.all)
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                VStack {
                    Spacer()
                    Text("問題数")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Spacer()
                    Text("\(gameViewModel.game.maxGameCount)")
                        .font(.system(size: 70))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            gameViewModel.gameCountDown()
                        } label: {
                            Image(systemName: "minus")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .frame(width: 70,height: 70)
                        .background(.mint.opacity(0.8))
                        .clipShape(Circle())                        .overlay(
                            Circle()
                                .stroke(Color.mint, lineWidth: 3)
                        )
                        Spacer()
                        Button {
                            gameViewModel.gameCountUp()
                        } label: {
                            Image(systemName: "plus")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .frame(width: 70,height: 70)
                        .background(.mint.opacity(0.8))
                        .clipShape(Circle())                        .overlay(
                            Circle()
                                .stroke(Color.mint, lineWidth: 3)
                        )
                        Spacer()
                    }
                    Spacer()
                    Button {
                        rootViewModel.nextGameView(nextView: .discussionView)
                    } label: {
                        Text("スタート")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.white)
                    }
                    .frame(width: 150,height: 50)
                    .background(.blue.opacity(0.8))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 3)
                    )
                    Spacer()
                }
            }.frame(width: UIScreen.main.bounds.width/1.2,height: UIScreen.main.bounds.height/1.5)
                .cornerRadius(20)
        }
    }
}

#Preview {
    GameCountView()
        .environmentObject(GameViewModel())
        .environmentObject(RootViewModel())
}
