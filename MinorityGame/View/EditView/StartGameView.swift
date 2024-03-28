//
//  StartGameView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct StartGameView: View {
    @ObservedObject var mainViewModel = MainViewModel()
    @EnvironmentObject var gameViewModel:GameViewModel

    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    Button {
                        gameViewModel.setView = true
                        gameViewModel.newGame()
                    } label: {
                        Text("新規ゲームを始める")
                    }
                }
                if mainViewModel.game.inGame{
                    VStack{
                        Button {
                            gameViewModel.setView = true
                        } label: {
                            Text("続きから再開する")
                        }
                    }
                }else{

                }
            }
        }
    }
}

#Preview {
    StartGameView()
        .environmentObject(GameViewModel())
}
