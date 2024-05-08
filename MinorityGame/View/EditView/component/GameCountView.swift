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
                            .modifier(TextFitToDevices(iPhone: 20, iPhoneSE: 15, iPad: 30))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .modifier(FrameFitToDevices(iPhone: (width: 30, height: 30),
                                                   iPhoneSE: (width: 25, height: 25),
                                                   iPad: (width: 50, height: 50)))

                    .background(.mint.opacity(0.8))
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.mint, lineWidth: 3)
                    )
                    Spacer()
                    Text("\(gameViewModel.game.maxGameCount)")
                        .modifier(TextFitToDevices(iPhone: 60, iPhoneSE: 50, iPad: 100))
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                    Spacer()
                    Button {
                        gameViewModel.gameCountUp()
                    } label: {
                        Image(systemName: "plus")
                            .modifier(TextFitToDevices(iPhone: 20, iPhoneSE: 15, iPad: 30))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .modifier(FrameFitToDevices(iPhone: (width: 30, height: 30),
                                                   iPhoneSE: (width: 25, height: 25),
                                                   iPad: (width: 50, height: 50)))
                    .background(.mint.opacity(0.8))
                    .clipShape(Circle())                        
                    .overlay(
                        Circle()
                            .stroke(Color.mint, lineWidth: 3)
                    )
                    Spacer()
                }
                Spacer()
            }
        }
        .modifier(FrameFitToDevices(iPhone: (width: 250, height: 120),
                               iPhoneSE: (width: 230, height: 100),
                               iPad: (width: 600, height: 200)))
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
