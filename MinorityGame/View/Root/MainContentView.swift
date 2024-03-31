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
        switch viewModel.rootView {
        case .editView:
            EditContentView()
        case .gameView:
            GameContentView()
        }
    }
}

#Preview {
    MainContentView()
        .environmentObject(GameViewModel())
}
