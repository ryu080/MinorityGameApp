//
//  VoteView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct VoteView: View {
    @EnvironmentObject var gameViewModel:GameViewModel
    @EnvironmentObject var alertViewModel:AlertViewModel
    @Environment(\.dismiss) var dismiss

    @State private var vote:Int = 0
    @State private var buttonColor:Bool?

    var user:User
    var body: some View {
        ZStack{
            Color.pennBlue
                .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Text("YESかNOを選んでください。")
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundStyle(Color.champagne)
                Spacer()
                ZStack{
                    Text(gameViewModel.questionText)
                        .font(.title)
                        .bold()
                        .foregroundStyle(Color.pennBlue)
                        .frame(width: UIScreen.main.bounds.width-20, height:150)
                        .background(Color.champagne)
                        .cornerRadius(20)
                }
                Spacer()
                HStack{
                    Spacer()
                    Button("YES"){
                        vote = 1
                        buttonColor = false
                    }
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor((buttonColor ?? true) ? .gray.opacity(0.7):.blue)
                    Spacer()
                    Button("NO"){
                        vote = 2
                        buttonColor = true
                    }
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor((buttonColor ?? false) ? .red :.gray.opacity(0.7))
                    Spacer()
                }
                Spacer()
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
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundStyle(Color.pennBlue)
                })
                .padding(10)
                .background(Color.champagne)
                .cornerRadius(10)
                Spacer()
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("\(user.name)さんの回答")
                                .foregroundColor(Color.champagne)
                                .fontWeight(.black)
                                .font(.title2)
                        }
                    }
            }
        }
    }
}

#Preview {
    VoteView(user: User(id: 1, name: "サンプル太",point: 0, totalPoints: 0, question: 0))
        .environmentObject(GameViewModel())
        .environmentObject(AlertViewModel())
}
