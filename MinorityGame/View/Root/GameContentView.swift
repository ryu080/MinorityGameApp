//
//  GameContentView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct GameContentView: View {
    @EnvironmentObject var viewModel:GameViewModel

    var body: some View {
        if viewModel.pageViewCount == 0{
            QuestionerView()
        }else if viewModel.pageViewCount == 1{
            DiscussionView()
        }else if viewModel.pageViewCount == 2{
            VoteListView()
        }else {
            ResultGameView()
        }
    }
}

#Preview {
    GameContentView()
        .environmentObject(GameViewModel())
}
