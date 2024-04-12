//
//  ContentView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct MainContentView: View {
    @EnvironmentObject var rootViewModel:RootViewModel

    var body: some View {
        switch rootViewModel.mainView {
        case .editView:
            EditContentView()
        case .gameView:
            GameContentView()
        }
    }
}

#Preview {
    MainContentView()
        .environmentObject(RootViewModel())
}
