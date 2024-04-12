//
//  EditContent.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct EditContentView: View {
    @EnvironmentObject private var rootViewModel:RootViewModel

    var body: some View {
        switch rootViewModel.editView {
        case .startGameView:
            StartGameView()
        case .editGameView:
            EditGameView()
        }
    }
}

#Preview {
    EditContentView()
        .environmentObject(RootViewModel())
}
