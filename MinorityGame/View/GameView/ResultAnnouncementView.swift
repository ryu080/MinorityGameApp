//
//  ResultAnnouncementView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/26.
//

import SwiftUI

struct ResultAnnouncementView: View {
    @EnvironmentObject private var gameViewModel: GameViewModel
    @EnvironmentObject private var questionViewModel: QuestionViewModel

    @State private var question:RealmQuestion?
    @State private var vote:(String,Color)?

    @State var isShowAnswerView:Int = 0
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                switch isShowAnswerView {
                case 1:
                    AnswerView(choice: question!.choice1, count: gameViewModel.yesUser().count, color: Color.electricBlue)
                        .transition(.scale)
                        .onTapGesture {
                            withAnimation {
                                isShowAnswerView = 2
                            }
                        }
                case 2: AnswerView(choice: question!.choice2, count: gameViewModel.noUser().count, color: Color.bittersweet)
                        .transition(.scale)
                        .onTapGesture {
                            withAnimation {
                                isShowAnswerView = 3
                            }
                        }
                case 3:MinorityView(winner: vote!.0, backgroundColor: vote!.1)
                        .transition(.scale)
                default:
                    BlurView(text: "集計中...", textSize: 30, startTime: 1)
                        .onAppear(){
                            Timer.scheduledTimer(withTimeInterval: 5, repeats: false) {timer in
                                withAnimation {
                                    isShowAnswerView = 1
                                }
                            }
                        }
                }
        }.onAppear(){
            question = questionViewModel.question!
            vote = gameViewModel.resultVote(choice1: question!.choice1, choice2: question!.choice2)
        }
    }
}

#Preview {
    ResultAnnouncementView()
            .environmentObject(GameViewModel())
            .environmentObject(QuestionViewModel())
}
