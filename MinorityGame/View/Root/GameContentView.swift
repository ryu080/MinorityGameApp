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
        NavigationView{
            Group{
                switch viewModel.gameView {
                case .questionView:
                    QuestionView()
                case .discussionView:
                    DiscussionView()
                case .voteListView:
                    VoteListView()
                case .resultGameView:
                    ResultGameView()
                }
            }
            .sheet(isPresented: $viewModel.isShowRule){
                RuleGameView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("ゲーム数:\(viewModel.nowGameCount)/\(viewModel.maxGameCount)")
                        .font(.title3)
                        .bold()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.isShowRule.toggle()
                    }) {
                        Text("ルール")
                    }
                }
            }
        }
    }
}

#Preview {
    GameContentView()
        .environmentObject(GameViewModel())
}
