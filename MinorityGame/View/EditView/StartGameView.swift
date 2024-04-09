//
//  StartGameView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct StartGameView: View {
    @EnvironmentObject var gameViewModel:GameViewModel
    @EnvironmentObject var realmViewModel:RealmViewModel

    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    Button {
                        realmViewModel.deleteGame(id: 0)
                        gameViewModel.editView = .editGameView
                    } label: {
                        Text("新規ゲームを始める")
                    }
                }
                if realmViewModel.readGame(id: 0) != nil{
                    VStack{
                        Button {
                            gameViewModel.game = realmViewModel.readGame(id: 0)!
                            gameViewModel.continueGame()
                            gameViewModel.rootView = .gameView
                        } label: {
                            Text("続きから再開する")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    StartGameView()
        .environmentObject(GameViewModel())
        .environmentObject(RealmViewModel())
}
