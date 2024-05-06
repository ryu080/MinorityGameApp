//
//  GameCountView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/05/05.
//

import SwiftUI

struct GameCountView: View {
    @EnvironmentObject private var gameViewModel:GameViewModel

    var body: some View {
        ZStack {
            Color.white
            VStack {
                Spacer()
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
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.mint, lineWidth: 3)
                    )
                    Spacer()
                    Text("\(gameViewModel.game.maxGameCount)")
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
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
        .frame(width: 250,height: 150)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.mint, lineWidth: 1)
        )
        .shadow(radius: 5)
    }
}

#Preview {
    GameCountView()
        .environmentObject(GameViewModel())
}
