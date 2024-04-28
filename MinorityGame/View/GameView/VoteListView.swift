//
//  VoteListView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct VoteListView: View {
    @EnvironmentObject private var rootViewModel:RootViewModel
    @EnvironmentObject private var gameViewModel:GameViewModel
    @EnvironmentObject private var alertViewModel:AlertViewModel

    var body: some View {
        ZStack {
            Color.pennBlue
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                List {
                    ForEach(gameViewModel.game.users) { user in
                        HStack {
                            Text(user.name)
                                .font(.title2)
                                .fontWeight(.black)
                                .foregroundStyle(Color.pennBlue)
                            Spacer()
                            Group {
                                if user.question == 0 {
                                    NavigationLink(""){
                                        VoteView(user: user)
                                    }.frame(width: 20)
                                } else {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 30))
                                        .foregroundStyle(.green)
                                }
                            }
                        }
                        .padding(10)
                        .listRowBackground(Color.champagne)
                    }
                }
                .frame(height: UIScreen.main.bounds.height/2)
                .scrollContentBackground(.hidden)
                Spacer()
                Button {
                    gameViewModel.voteComplete() ? rootViewModel.nextGameView(nextView: .resultAnnouncementView): alertViewModel.voteListAlert()
                } label: {
                    Text("投票を終わる")
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundStyle(Color.pennBlue)
                }
                .padding(10)
                .background(Color.champagne)
                .cornerRadius(10)

                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("投票")
                    .foregroundColor(Color.champagne)
                    .fontWeight(.black)
                    .font(.title2)
            }
        }
        .alert(alertViewModel.alertTitle, isPresented: $alertViewModel.isShowAlert) {
        } message: {
            Text(alertViewModel.alertMessage)
        }
    }
}

#Preview {
    VoteListView()
        .environmentObject(RootViewModel())
        .environmentObject(GameViewModel())
        .environmentObject(AlertViewModel())
}
