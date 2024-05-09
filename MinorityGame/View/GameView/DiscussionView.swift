//
//  DiscussionView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct DiscussionView: View {
    @EnvironmentObject private var rootViewModel:RootViewModel
    @EnvironmentObject private var gameViewModel:GameViewModel
    //    @EnvironmentObject private var realmViewModel:RealmViewModel
    @EnvironmentObject private var alertViewModel:AlertViewModel
    @EnvironmentObject private var questionViewModel:QuestionViewModel
    @EnvironmentObject private var genreViewModel:GenreViewModel
    @StateObject private var timerViewModel = TimerViewModel()

    @State private var isShowProgress:Bool = true

    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            if isShowProgress {
                BlurView(text: "読み込み中...", textSize: 30, startTime: 1)
                    .onAppear(){
                        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) {timer in
                            questionViewModel.question = gameViewModel.game.questions[gameViewModel.game.nowGameCount-1]
                            withAnimation {
                                isShowProgress = false
                                timerViewModel.startCountDown()
                            }
                        }
                    }
            } else {
                VStack {
                    Spacer()
                    VStack(spacing:0) {
                        Spacer()
                        Text("Thinking Time")
                            .modifier(TextFitToDevices(iPhone: 30, iPhoneSE: 25, iPad: 40))
                            .fontWeight(.black)
                            .foregroundStyle(Color.white)
                        Text(timerViewModel.dateFormat(minutes: timerViewModel.timeCount.minutesCount,
                                                       seconds: timerViewModel.timeCount.secondsCount))
                        .modifier(TextFitToDevices(iPhone: 50, iPhoneSE: 40, iPad: 80))
                        .fontWeight(.black)
                        .foregroundStyle(Color.white)
                        HStack {
                            Spacer()
                            Group {
                                if timerViewModel.timer == nil {
                                    Button(action: {
                                        timerViewModel.startCountDown()
                                    }, label: {
                                        Image(systemName: "play.fill")
                                            .modifier(TextFitToDevices(iPhone: 30, iPhoneSE: 25, iPad: 40))
                                    })
                                } else {
                                    Button(action: {
                                        timerViewModel.stopCountDown()
                                    }, label: {
                                        Image(systemName: "pause.fill")
                                            .modifier(TextFitToDevices(iPhone: 30, iPhoneSE: 25, iPad: 40))
                                    })
                                }
                            }
                            Spacer()
                            Text("1min")
                                .modifier(TextFitToDevices(iPhone: 30, iPhoneSE: 25, iPad: 40))
                                .fontWeight(.black)
                                .foregroundStyle(Color.white)
                            Spacer()
                            Button(action: {
                                timerViewModel.minusMinutes()
                            }, label: {
                                Image(systemName: "minus")
                                    .modifier(TextFitToDevices(iPhone: 20, iPhoneSE: 18, iPad: 30))
                                    .foregroundStyle(.red)
                                    .bold()
                            })
                            Spacer()
                            Button(action: {
                                timerViewModel.plusMinutes()
                            }, label: {
                                Image(systemName: "plus")
                                    .modifier(TextFitToDevices(iPhone: 20, iPhoneSE: 18, iPad: 30))
                                    .bold()
                            })
                            Spacer()
                        }
                        .modifier(FrameFitToDevices(iPhone: (width: 200, height: 40),
                                                    iPhoneSE: (width: 200, height: 35),
                                                    iPad: (width: 300, height: 50)))
                        .background(Color.mint.opacity(0.7))
                        .cornerRadius(20)
                        .overlay() {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.mint, lineWidth: 4)
                        }
                    }.frame(height: 80,alignment: .top)
                    Spacer()
                    ZStack {
                        RoundedCorners(color: .white, tl: 50, tr: 50, bl: 0, br: 0)
                            .shadow(radius: 5)
                        VStack {
                            VStack {
                                Spacer()
                                Text("【第\(gameViewModel.game.nowGameCount)門】")
                                    .modifier(TextFitToDevices(iPhone: 35, iPhoneSE: 30, iPad: 50))
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.black)
                                Spacer()
                                Text(questionViewModel.question?.text ?? "旅行に行くならどっち？")
                                    .modifier(TextFitToDevices(iPhone: 28, iPhoneSE: 23, iPad: 40))
                                    .bold()
                                    .foregroundStyle(Color.white)
                                    .modifier(FrameFitToDevices(iPhone: (width: 350, height: 150),
                                                                iPhoneSE: (width: 320, height: 130),
                                                                iPad: (width: 800, height: 250)))
                                    .background(LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .top, endPoint: .bottom))
                                    .cornerRadius(20)
                                    .overlay() {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.mint, lineWidth: 3)
                                    }
                                Spacer()
                                HStack {
                                    Text(questionViewModel.question?.choice1 ?? "北海道")
                                        .modifier(TextFitToDevices(iPhone: 25, iPhoneSE: 20, iPad: 35))
                                        .bold()
                                        .foregroundStyle(Color.electricBlue)
                                        .modifier(FrameFitToDevices(iPhone: (width: 160, height: 100),
                                                                    iPhoneSE: (width: 140, height: 80),
                                                                    iPad: (width: 300, height: 180)))
                                        .background(Color.white)
                                        .cornerRadius(20)
                                        .overlay() {
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.gray, lineWidth: 2)
                                        }
                                    Spacer()
                                    Text(questionViewModel.question?.choice2 ?? "沖縄県")
                                        .modifier(TextFitToDevices(iPhone: 25, iPhoneSE: 20, iPad: 35))
                                        .bold()
                                        .foregroundStyle(Color.bittersweet)
                                        .modifier(FrameFitToDevices(iPhone: (width: 160, height: 100),
                                                                    iPhoneSE: (width: 140, height: 80),
                                                                    iPad: (width: 300, height: 180)))
                                        .background(Color.white)
                                        .cornerRadius(20)
                                        .overlay() {
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.gray, lineWidth: 2)
                                        }
                                }.modifier(FrameFitToDevices(iPhone: (width: 350, height: nil),
                                                             iPhoneSE: (width: 320, height: nil),
                                                             iPad: (width: 800, height: nil)))
                                Spacer()
                                VStack{
                                    Button(action: {
                                        alertViewModel.discussionAlert()
                                    }, label: {
                                        Text("投票画面へ")
                                            .modifier(TextFitToDevices(iPhone: 30, iPhoneSE: 25, iPad: 40))
                                            .fontWeight(.black)
                                            .foregroundStyle(Color.white)
                                    })
                                    .modifier(FrameFitToDevices(iPhone: (width: 300, height: 50),
                                                                iPhoneSE: (width: 230, height: 40),
                                                                iPad: (width: 600, height: 100)))
                                    .background(.mint.opacity(0.8))
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.mint, lineWidth: 3)
                                    )
                                }
                                Spacer()
                            }.modifier(FrameFitToDevices(iPhone: (width: nil, height: 480),
                                                         iPhoneSE: (width: nil, height: 370),
                                                         iPad: (width: nil, height: 750)))
                            Spacer()
                        }.modifier(FrameFitToDevices(iPhone: (width: nil, height: 550),
                                                     iPhoneSE: (width: nil, height: 400),
                                                     iPad: (width: nil, height: 800)))
                    }
                    .modifier(FrameFitToDevices(iPhone: (width: nil, height: 550),
                                                                     iPhoneSE: (width: nil, height: 400),
                                                                     iPad: (width: nil, height: 800)))
                }
                .transition(.move(edge: .bottom))
                .edgesIgnoringSafeArea(.all)
                .alert(alertViewModel.alertTitle, isPresented: $alertViewModel.isShowAlert) {
                    Button("戻る",role: .cancel){}
                    Button("投票へ"){
                        rootViewModel.nextGameView(nextView: .voteListView)
                        timerViewModel.stopCountDown()
                        timerViewModel.setCountDown()
                    }
                } message: {
                    Text(alertViewModel.alertMessage)
                }
            }
        }
    }
}

#Preview {
    DiscussionView()
        .environmentObject(RootViewModel())
        .environmentObject(GameViewModel())
    //        .environmentObject(RealmViewModel())
        .environmentObject(GenreViewModel())
        .environmentObject(AlertViewModel())
        .environmentObject(QuestionViewModel())
}
