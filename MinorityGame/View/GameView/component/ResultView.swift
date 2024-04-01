//
//  ResultView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var viewModel:GameViewModel
    @State var yesCount:Int = 0
    @State var noCount:Int = 0
    @State var winer:String = ""

    var body: some View {
        VStack{
            Text(viewModel.questionText)
            HStack{
                Text("YES\(yesCount)人")
                Text("NO\(noCount)人")
            }
            Text(winer)
            List(viewModel.users){user in
                HStack{
                    Text(user.name)
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
            self.yesCount = viewModel.yesUserCount()
            self.noCount = viewModel.noUserCount()
            self.winer = viewModel.resultVote()
        }
    }
}

#Preview {
    ResultView()
        .environmentObject(GameViewModel())
}
