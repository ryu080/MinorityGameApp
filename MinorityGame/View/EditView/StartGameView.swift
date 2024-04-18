//
//  StartGameView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct StartGameView: View {
    @EnvironmentObject private var rootViewModel:RootViewModel
    @EnvironmentObject private var gameViewModel:GameViewModel
    @EnvironmentObject private var realmViewModel:RealmViewModel

    var body: some View {
        ZStack {
            Color.pennBlue
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("少数派ゲーム")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundStyle(Color.champagne)
                Spacer()
                Button {
                    realmViewModel.deleteGame(id: 0)
                    rootViewModel.editView = .editGameView
                } label: {
                    Text("新規ゲームを始める")
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundStyle(Color.pennBlue)
                }
                .padding(10)
                .background(Color.champagne)
                .cornerRadius(10)
                if realmViewModel.readGame(id: 0) != nil {
                    Button {
                        gameViewModel.game = realmViewModel.readGame(id: 0)!
                        gameViewModel.continueGame()
                        rootViewModel.mainView = .gameView
                    } label: {
                        Text("続きから再開する")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundStyle(Color.champagne)
                    }
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.champagne, lineWidth: 4)
                    )
                }
                Spacer()
            }
        }
    }
}

#Preview {
    StartGameView()
        .environmentObject(RootViewModel())
        .environmentObject(GameViewModel())
        .environmentObject(RealmViewModel())
}
