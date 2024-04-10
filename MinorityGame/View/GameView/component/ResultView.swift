//
//  ResultView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var gameViewModel:GameViewModel
    @State var yesCount:Int = 0
    @State var noCount:Int = 0
    @State var winer:String = ""

    var body: some View {
        VStack{
            Text(gameViewModel.questionText)
            HStack{
                Text("YES\(yesCount)人")
                Text("NO\(noCount)人")
            }
            Text(winer)
            List(gameViewModel.game.users.reversed()){user in
                HStack{
                    Text(user.name)
                    Text("合計\(user.totalPoints)")
                    Spacer()
                    if user.question == 1{
                        Text("YES")
                            .foregroundStyle(.blue)
                    }else if user.question == 2 {
                        Text("NO")
                            .foregroundStyle(.red)
                    }
                    Text("\(user.point)")
                }
            }
            .scrollContentBackground(.hidden)
            .frame(height: 400)
            .cornerRadius(20)
        }
        .onAppear(){
            self.yesCount = gameViewModel.yesUserCount()
            self.noCount = gameViewModel.noUserCount()
            self.winer = gameViewModel.resultVote()
        }
    }
}

#Preview {
    ResultView()
        .environmentObject(GameViewModel())
}
