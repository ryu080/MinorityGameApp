//
//  ContentView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct MainContentView: View {
    @EnvironmentObject var gameViewModel:GameViewModel
    @EnvironmentObject var realmViewModel:RealmViewModel
    @EnvironmentObject var alertViewModel:AlertViewModel

    var body: some View {
        switch gameViewModel.rootView {
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
        .environmentObject(RealmViewModel())
        .environmentObject(AlertViewModel())
}
