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
                        VStack {
                            Spacer()
                            Text("どちらかを選んでください")
                                .modifier(TextFitToDevices(iPhone: 25, iPhoneSE: 20, iPad: 40))
                                .fontWeight(.black)
                            Spacer()
                            Text(questionViewModel.question?.text ?? "旅行に行くならどっち？")
                                .modifier(TextFitToDevices(iPhone: 28, iPhoneSE: 23, iPad: 40))
                                .bold()
                                .foregroundStyle(Color.white)
                                .modifier(FrameFitToDevices(iPhone: (width: 350, height: 150),
                                                            iPhoneSE: (width: 320, height: 130),
                                                            iPad: (width: 500, height: 200)))
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
                                .modifier(TextFitToDevices(iPhone: 25, iPhoneSE: 20, iPad: 30))
                                .bold()
                                .foregroundStyle(Color.white)
                                .modifier(FrameFitToDevices(iPhone: (width: 160, height: 100),
                                                            iPhoneSE: (width: 140, height: 80),
                                                            iPad: (width: 200, height: 130)))
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
                                .modifier(TextFitToDevices(iPhone: 25, iPhoneSE: 20, iPad: 30))
                                .bold()
                                .foregroundStyle(Color.white)
                                .modifier(FrameFitToDevices(iPhone: (width: 160, height: 100),
                                                            iPhoneSE: (width: 140, height: 80),
                                                            iPad: (width: 200, height: 130)))
                                .background((buttonColor ?? false) ? Color.bittersweet :.gray.opacity(0.7))
                                .cornerRadius(20)
                                .overlay() {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.bittersweet, lineWidth: 3)
                                }
                            }.modifier(FrameFitToDevices(iPhone: (width: 350, height: nil),
                                                         iPhoneSE: (width: 320, height: nil),
                                                         iPad: (width: 500, height: nil)))
                            Spacer()
                            Button(action: {
                                alertViewModel.voteAlert(vote: vote, choice1: questionViewModel.question!.choice1, choice2: questionViewModel.question!.choice2)
                            }, label: {
                                Text("投票する")
                                    .modifier(TextFitToDevices(iPhone: 30, iPhoneSE: 25, iPad: 40))
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.white)
                            })
                            .modifier(FrameFitToDevices(iPhone: (width: 300, height: 40),
                                                        iPhoneSE: (width: 230, height: 35),
                                                        iPad: (width: 500, height: 80)))
                            .background(Color.mint.opacity(0.8))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.mint, lineWidth: 3)
                            )
                            Spacer()
                        }
                        .modifier(FrameFitToDevices(iPhone: (width: nil, height: 480),
                                                     iPhoneSE: (width: nil, height: 370),
                                                     iPad: (width: 550, height: 700)))
                        Spacer()
                            .toolbar {
                                ToolbarItem(placement: .principal) {
                                    Text("\(user.name)さんの回答")
                                        .foregroundColor(Color.champagne)
                                        .fontWeight(.black)
                                        .font(.title2)
                                }
                            }
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
                    }.modifier(FrameFitToDevices(iPhone: (width: nil, height: 550),
                                                 iPhoneSE: (width: nil, height: 400),
                                                 iPad: (width: 550, height: 700)))
                }
                .modifier(FrameFitToDevices(iPhone: (width: nil, height: 550),
                                            iPhoneSE: (width: nil, height: 400),
                                            iPad: (width: 550, height: 700)))
            }
            .transition(.move(edge: .bottom))
            .edgesIgnoringSafeArea(.all)
        }
    }
}
