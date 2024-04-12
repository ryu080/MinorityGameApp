//
//  GameContentView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct GameContentView: View {
    @EnvironmentObject var rootViewModel:RootViewModel
    @EnvironmentObject var gameViewModel:GameViewModel

    var body: some View {
        NavigationView{
            Group{
                switch rootViewModel.gameView {
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
            .sheet(isPresented: $gameViewModel.isShowRule){
                RuleGameView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("ゲーム数:\(gameViewModel.game.nowGameCount)/\(gameViewModel.game.maxGameCount)")
                        .font(.title3)
                        .foregroundStyle(Color.champagne)
                        .fontWeight(.black)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        gameViewModel.isShowRule.toggle()
                    }) {
                        Text("ルール")
                            .font(.title3)
                            .fontWeight(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    GameContentView()
        .environmentObject(RootViewModel())
        .environmentObject(GameViewModel())
}
