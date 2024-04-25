//
//  VoteView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct VoteView: View {
    @EnvironmentObject private var gameViewModel:GameViewModel
    @EnvironmentObject private var alertViewModel:AlertViewModel
    @EnvironmentObject private var questionViewModel:QuestionViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var vote:Int = 0
    @State private var buttonColor:Bool?

    var user:User
    var body: some View {
        ZStack {
            Color.pennBlue
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("どちらかを選んでください。")
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundStyle(Color.champagne)
                Spacer()
                ZStack {
                    Text(questionViewModel.question!.text)
                        .font(.title)
                        .bold()
                        .foregroundStyle(Color.pennBlue)
                        .frame(width: UIScreen.main.bounds.width-20, height:150)
                        .background(Color.champagne)
                        .cornerRadius(20)
                        .overlay() {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.amaranthPurple, lineWidth: 5)
                        }
                }
                Spacer()
                HStack {
                    Spacer()
                    Button(questionViewModel.question!.choice1) {
                        vote = 1
                        buttonColor = false
                    }
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor((buttonColor ?? true) ? .gray.opacity(0.7):.blue)
                    Spacer()
                    Button(questionViewModel.question!.choice2) {
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
                    if vote == 0 {
                        alertViewModel.voteAlert()
                    } else {
                        gameViewModel.updateUserQuestion(id: user.id, question: vote)
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
        .environmentObject(QuestionViewModel())
}
