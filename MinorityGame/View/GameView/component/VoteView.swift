//
//  VoteView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct VoteView: View {
    @EnvironmentObject var gameViewModel:GameViewModel
    @EnvironmentObject var realmViewModel:RealmViewModel
    @EnvironmentObject var alertViewModel:AlertViewModel
    @Environment(\.dismiss) var dismiss

    @State var vote:Int = 0
    @State private var buttonColor:Bool?

    var user:User
    var body: some View {
        ZStack{
            VStack{
                ZStack{
                    Text(gameViewModel.questionText)
                        .font(.title)
                        .bold()
                        .frame(alignment: .center)
                        .foregroundStyle(.black)
                }
                HStack{
                    Spacer()
                    Button("YES"){
                        vote = 1
                        buttonColor = false
                    }
                    .font(.title)
                    .bold()
                    .foregroundColor((buttonColor ?? true) ? .gray.opacity(0.7):.blue)
                    Spacer()
                    Button("NO"){
                        vote = 2
                        buttonColor = true
                    }
                    .font(.title)
                    .bold()
                    .foregroundColor((buttonColor ?? false) ? .red :.gray.opacity(0.7))
                    Spacer()
                }
                Button(action: {
                    if vote == 0{
                        alertViewModel.voteAlert()
                    }else{
                        gameViewModel.questionUser(id: user.id, question: vote)
                        dismiss()
                        buttonColor = nil
                    }
                }, label: {
                     Text("投票する")
                })
                .navigationTitle("\(user.name)さんの回答")
            }
        }
    }
}

#Preview {
    VoteView(user: User(id: 1, name: "サンプル太",point: 0, totalPoints: 0, question: 0))
        .environmentObject(GameViewModel())
        .environmentObject(RealmViewModel())
        .environmentObject(AlertViewModel())
}
