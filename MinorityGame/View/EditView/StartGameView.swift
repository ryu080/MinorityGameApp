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
            Button {
                gameViewModel.setView = true
            } label: {
                Text("NewGame")
            }

            List(mainViewModel.games){game in

            }
        }
    }
}

#Preview {
    StartGameView()
        .environmentObject(GameViewModel())
}
