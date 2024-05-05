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

    @State var isShowProgress:Bool = true

    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            if isShowProgress {
                BlurView(text: "読み込み中...", textSize: 30, startTime: 1)
                    .onAppear(){
                        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) {timer in
//                            if questionViewModel.isFirstLoadingQuestions{
//                                questionViewModel.setUseQuestionsRealm(maxGameCount: gameViewModel.game.maxGameCount, genre: genreViewModel.genreName!)
//                                questionViewModel.isFirstLoadingQuestions = false
//                            }
//                            questionViewModel.getRandomQuestionRealm(nowGameCount: gameViewModel.game.nowGameCount)
                            questionViewModel.question = gameViewModel.game.questions[gameViewModel.game.nowGameCount]
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
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundStyle(Color.white)
                        Text(timerViewModel.dateFormat(minutes: timerViewModel.timeCount.minutesCount,
                                                       seconds: timerViewModel.timeCount.secondsCount))
                        .font(.system(size: 50))
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
                                            .font(.title)
                                    })
                                } else {
                                    Button(action: {
                                        timerViewModel.stopCountDown()
                                    }, label: {
                                        Image(systemName: "pause.fill")
                                            .font(.title)
                                    })
                                }
                            }
                            Spacer()
                            Text("1min")
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundStyle(Color.white)
                            Spacer()
                            Button(action: {
                                timerViewModel.minusMinutes()
                            }, label: {
                                Image(systemName: "minus")
                                    .font(.title3)
                                    .foregroundStyle(.red)
                                    .bold()
                            })
                            Spacer()
                            Button(action: {
                                timerViewModel.plusMinutes()
                            }, label: {
                                Image(systemName: "plus")
                                    .font(.title3)
                                    .bold()
                            })
                            Spacer()
                        }
                        .frame(width: 200,height: 40)
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
                        VStack{
                            Text("【第\(gameViewModel.game.nowGameCount)門】")
                                .font(.system(size: 35))
                                .fontWeight(.black)
                                .foregroundStyle(Color.black)
                                .padding(5)
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
                            HStack {
                                Text(questionViewModel.question?.choice1 ?? "北海道")
                                    .font(.title)
                                    .bold()
                                    .foregroundStyle(Color.white)
                                    .frame(width: 160,height: 100)
                                    .background(Color.electricBlue)
                                    .cornerRadius(20)
                                    .overlay() {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.electricBlue, lineWidth: 3)
                                    }
                                Spacer()
                                Text(questionViewModel.question?.choice2 ?? "沖縄県")
                                    .font(.title)
                                    .bold()
                                    .foregroundStyle(Color.white)
                                    .frame(width: 160, height: 100)
                                    .background(Color.bittersweet)
                                    .cornerRadius(20)
                                    .overlay() {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.bittersweet, lineWidth: 3)
                                    }
                            }.frame(width: UIScreen.main.bounds.width-20,height: 140)
                            Button(action: {
                                alertViewModel.discussionAlert()
                            }, label: {
                                Text("投票画面へ")
                                    .font(.title)
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.white)
                            })
                            .frame(width: UIScreen.main.bounds.width-20,height: 50)
                            .background(.mint.opacity(0.8))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.mint, lineWidth: 3)
                            )

                            Spacer()
                        }.frame(height:UIScreen.main.bounds.height/1.5)
                    }
                    .frame(height:UIScreen.main.bounds.height/1.5)
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
