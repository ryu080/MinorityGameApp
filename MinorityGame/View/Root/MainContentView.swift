//
//  ContentView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct MainContentView: View {
    @EnvironmentObject var viewModel:GameViewModel

    var body: some View {
        if viewModel.mainOrGameView{
            GameContentView()
        }else{
            EditContentView()
        }
    }
}

#Preview {
    MainContentView()
        .environmentObject(GameViewModel())
}
