//
//  EditContent.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct EditContentView: View {
    @EnvironmentObject var viewModel:GameViewModel

    var body: some View {
        if viewModel.setView{
            EditGameView()
        }else {
            StartGameView()
        }
    }
}

#Preview {
    EditContentView()
        .environmentObject(GameViewModel())
}
