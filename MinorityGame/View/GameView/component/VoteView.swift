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

    @Binding var user:User
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                PlayerView(playerImageData: user.imageData, name: user.name, backgroundColor: .mint, opacity: 0.7)
                    .scaleEffect(x: 1.3, y: 1.3)
                Spacer()
                ZStack {
                    RoundedCorners(color: .white, tl: 50, tr: 50, bl: 0, br: 0)
                        .compositingGroup()
                        .shadow(radius: 5)
                    VStack {
                        Text("どちらかを選んでください")
                            .font(.system(size: 25))
                            .fontWeight(.black)
                            .foregroundStyle(Color.black)
                            .frame(width: UIScreen.main.bounds.width-20)
                            .padding()
                        Text(questionViewModel.question?.text ?? "旅行に行くならどっち？")
                            .font(.title)
                            .bold()
                            .foregroundStyle(Color.white)
                            .frame(width: UIScreen.main.bounds.width-20, height:150)
                            .background(LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(20)
                            .overlay() {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.mint, lineWidth: 3)
                            }
                        Spacer()
                        HStack {
                            Button(questionViewModel.question?.choice1 ?? "北海道") {
                                vote = 1
                                buttonColor = false
                            }
                            .font(.title2)
                            .bold()
                            .foregroundStyle(Color.white)
                            .frame(width: 160,height: 100)
                            .background((buttonColor ?? true) ? .gray.opacity(0.7):Color.electricBlue)
                            .cornerRadius(20)
                            .overlay() {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.electricBlue, lineWidth: 3)
                            }
                            Spacer()
                            Button(questionViewModel.question?.choice2 ?? "沖縄県") {
                                vote = 2
                                buttonColor = true
                            }
                            .font(.title2)
                            .bold()
                            .foregroundStyle(Color.white)
                            .frame(width: 160, height: 100)
                            .background((buttonColor ?? false) ? Color.bittersweet :.gray.opacity(0.7))
                            .cornerRadius(20)
                            .overlay() {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.bittersweet, lineWidth: 3)
                            }
                        }.frame(width: UIScreen.main.bounds.width-20)
                        Spacer()
                        Button(action: {
                            alertViewModel.voteAlert(vote: vote, choice1: questionViewModel.question!.choice1, choice2: questionViewModel.question!.choice2)
                        }, label: {
                            Text("投票する")
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundStyle(Color.white)
                        })
                        .frame(width: 200,height: 50)
                        .background(Color.mint.opacity(0.8))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.mint, lineWidth: 3)
                        )

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
                    .frame(height:UIScreen.main.bounds.height/1.5)
                    .alert(isPresented: $alertViewModel.isShowAlert) {
                        switch alertViewModel.alertType {
                        case .success:
                            return Alert(title: Text(alertViewModel.alertTitle),
                                         message: Text(alertViewModel.alertMessage),
                                         primaryButton: .cancel(Text("いいえ")),
                                         secondaryButton: .default(Text("はい"),
                                                                   action: {
                                gameViewModel.updateUserQuestion(id: user.id, question: vote)
                                dismiss()
                                buttonColor = nil
                                                }))
                        case .delete:
                            return Alert(title: Text(alertViewModel.alertTitle),
                                           message: Text(alertViewModel.alertMessage),
                                         primaryButton: .cancel(Text("戻る")),
                                         secondaryButton: .destructive(Text("削除"),
                                                                       action: {
                            }))
                        case .error:
                            return Alert(title: Text(alertViewModel.alertTitle),
                                           message: Text(alertViewModel.alertMessage),
                                                      dismissButton: .default(Text("OK"),
                                                                              action: {
                                                }))
                        }
                    }

                }
                .frame(width: UIScreen.main.bounds.width,height:UIScreen.main.bounds.height/1.6)
            }
            .transition(.move(edge: .bottom))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

//#Preview {
//    VoteView(user: )
//        .environmentObject(GameViewModel())
//        .environmentObject(AlertViewModel())
//        .environmentObject(QuestionViewModel())
//}
