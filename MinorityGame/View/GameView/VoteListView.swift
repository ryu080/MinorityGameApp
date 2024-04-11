//
//  VoteListView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI
import RealmSwift

struct VoteListView: View {
    @EnvironmentObject var gameViewModel:GameViewModel
    //    @EnvironmentObject var realmViewModel:RealmViewModel
    @EnvironmentObject var alertViewModel:AlertViewModel

    var body: some View {
        ZStack{
            VStack{
                List{
                    ForEach(gameViewModel.game.users){ user in
                        HStack{
                            Text(user.name)
                                .font(.title2)
                                .bold()
                                .frame(height: 40)
                            Spacer()
                            if user.question == 0{
                                NavigationLink(""){
                                    VoteView(user: user)
                                }
                            }else{
                                Text("投票済")
                                    .font(.title3)
                                    .bold()
                                    .foregroundStyle(.red)
                            }

                        }.padding(10)
                    }
                }
                .scrollContentBackground(.hidden)
                Button("投票を終わる"){
                    alertViewModel.voteListAlert(complete: gameViewModel.voteComplete())
                }
                Spacer()
            }
        }
        .navigationBarTitle("投票", displayMode:  .inline)

        .alert(alertViewModel.alertTitle, isPresented: $alertViewModel.isShowAlert) {
        } message: {
            Text(alertViewModel.alertMessage)
        }
    }
}

#Preview {
    VoteListView()
        .environmentObject(GameViewModel())
    //        .environmentObject(RealmViewModel())
        .environmentObject(AlertViewModel())
}
