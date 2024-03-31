//
//  DiscussionView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct DiscussionView: View {
    @EnvironmentObject var viewModel:GameViewModel

    var body: some View {
        ZStack{
            VStack{
                ZStack{
                    Text(viewModel.questionText)
                        .font(.largeTitle)
                        .bold()
                        .frame(alignment: .center)
                        .foregroundStyle(.black)
                }
                HStack{
                    Spacer()
                    Text("YES")
                    Spacer()
                    Text("NO")
                    Spacer()
                }
                Text("シンキングタイム")
                //タイマーを設置
                Button(action: {
                    viewModel.gameView = .voteListView
                }, label: {
                    Text("投票画面へ")
                })
            }
        }
    }
}

#Preview {
    DiscussionView()
        .environmentObject(GameViewModel())
}
