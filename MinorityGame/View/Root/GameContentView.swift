//
//  GameContentView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct GameContentView: View {
    @EnvironmentObject private var rootViewModel:RootViewModel
    @EnvironmentObject private var gameViewModel:GameViewModel

    var body: some View {
        NavigationView {
            Group {
                switch rootViewModel.gameView {
                case .discussionView:
                    DiscussionView()
                case .voteListView:
                    VoteListView()
                case .resultAnnouncementView:
                    ResultAnnouncementView()
                case .resultGameView:
                    ResultGameView()
                }
            }
            .sheet(isPresented: $gameViewModel.isShowRule) {
                RuleGameView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("ゲーム数:\(gameViewModel.game.nowGameCount)/\(gameViewModel.game.maxGameCount)")
                        .font(.title3)
                        .foregroundStyle(Color.white)
                        .fontWeight(.black)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        gameViewModel.isShowRule.toggle()
                    } label: {
                        Text("ルール")
                            .font(.title3)
                            .fontWeight(.black)
                            .foregroundStyle(.white)
                    }
                }
            }
        }.navigationViewStyle(.stack)
    }
}

#Preview {
    GameContentView()
        .environmentObject(RootViewModel())
        .environmentObject(GameViewModel())
}
