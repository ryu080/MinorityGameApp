//
//  DiscussionView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct DiscussionView: View {
    @EnvironmentObject var viewModel:GameViewModel
    @ObservedObject var timerViewModel = TimerViewModel()

    var body: some View {
        ZStack{
            VStack{
                ZStack{
                    Text(viewModel.questionText)
                        .font(.largeTitle)
                        .bold()
                        .frame(alignment: .center)
                        .foregroundStyle(.black)
                }
                HStack{
                    Spacer()
                    Text("YES")
                    Spacer()
                    Text("NO")
                    Spacer()
                }
                Text("シンキングタイム")

                Text(timerViewModel.dateFormat(minutes: timerViewModel.timeCount.minutesCount, seconds: timerViewModel.timeCount.secondsCount))
                    .font(.largeTitle)
                HStack{
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
                }
                HStack{
                    Spacer()
                    Text("1min")
                        .font(.title)
                    Button(action: {
                        timerViewModel.plusMinutes()
                    }, label: {
                        Text("+")
                            .font(.title)
                    })
                    Button(action: {
                        timerViewModel.minusMinutes()
                    }, label: {
                        Text("-")
                            .font(.title)
                    })
                    Spacer()
                }
                Button(action: {
                    viewModel.gameView = .voteListView
                    timerViewModel.stopCountDown()
                    timerViewModel.setCountDown()
                }, label: {
                    Text("投票画面へ")
                })
            }
        }
    }
}

#Preview {
    DiscussionView()
        .environmentObject(GameViewModel())
}
