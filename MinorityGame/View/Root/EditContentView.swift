//
//  EditContent.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct EditContentView: View {
    @EnvironmentObject var gameViewModel:GameViewModel
    @EnvironmentObject var realmViewModel:RealmViewModel

    var body: some View {
        switch gameViewModel.editView {
        case .startGameView:
            StartGameView()
        case .editGameView:
            EditGameView()
        }
    }
}

#Preview {
    EditContentView()
        .environmentObject(GameViewModel())
        .environmentObject(RealmViewModel())
}
