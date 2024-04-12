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
    @EnvironmentObject private var realmViewModel:RealmViewModel
    @EnvironmentObject private var alertViewModel:AlertViewModel
    @ObservedObject private var timerViewModel = TimerViewModel()

    var body: some View {
        ZStack{
            Color.pennBlue
                .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Text("Thinking Time")
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundStyle(Color.champagne)
                VStack{
                Text(timerViewModel.dateFormat(minutes: timerViewModel.timeCount.minutesCount, seconds: timerViewModel.timeCount.secondsCount))
                    .font(.system(size: 50))
                    .fontWeight(.black)
                    .foregroundStyle(Color.champagne)
                    HStack{
                        Spacer()
                        if timerViewModel.timer == nil{
                            Button(action: {
                                timerViewModel.startCountDown()
                            }, label: {
                                Image(systemName: "play.fill")
                                    .font(.title)
                            })
                        } else{
                            Button(action: {
                                timerViewModel.stopCountDown()
                            }, label: {
                                Image(systemName: "pause.fill")
                                    .font(.title)
                            })
                        }
                        Spacer()
                        Text("1min")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundStyle(Color.pennBlue)
                        Spacer()
                        Button(action: {
                            timerViewModel.plusMinutes()
                        }, label: {
                            Image(systemName: "plus")
                                .font(.title3)
                                .bold()
                        })
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
                    }
                    .frame(width: 200)
                    .background(Color.champagne)
                    .cornerRadius(20)
                }.padding(10)
                ZStack{
                    Text(gameViewModel.questionText)
                        .font(.title)
                        .bold()
                        .foregroundStyle(Color.pennBlue)
                        .frame(width: UIScreen.main.bounds.width-20, height:150)
                        .background(Color.champagne)
                        .cornerRadius(20)
                        .overlay() {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.umber, lineWidth: 5)
                        }

                }
                HStack{
                    Spacer()
                    Text("YES")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.blue)
                    Spacer()
                    Text("NO")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.red)
                    Spacer()
                }
                Spacer()
                Button(action: {
                    alertViewModel.discussionAlert()
                }, label: {
                    Text("投票画面へ")
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundStyle(Color.pennBlue)
                })
                .padding(10)
                .background(Color.champagne)
                .cornerRadius(10)
                Spacer()
            }
        }
        .alert(alertViewModel.alertTitle, isPresented: $alertViewModel.isShowAlert) {
            Button("戻る",role: .cancel){}
            Button("投票へ"){
                rootViewModel.gameView = .voteListView
                timerViewModel.stopCountDown()
                timerViewModel.setCountDown()
            }
        } message: {
            Text(alertViewModel.alertMessage)
        }
    }
}

#Preview {
    DiscussionView()
        .environmentObject(RootViewModel())
        .environmentObject(GameViewModel())
        .environmentObject(RealmViewModel())
        .environmentObject(AlertViewModel())
}
