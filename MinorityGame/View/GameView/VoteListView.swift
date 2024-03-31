//
//  VoteListView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct VoteListView: View {
    @EnvironmentObject var viewModel:GameViewModel
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    List{
                        ForEach(viewModel.users){ user in
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
                        viewModel.voteCompleta()
                    }
                    Spacer()
                }
                .navigationBarTitle("投票", displayMode:  .inline)
            }
        }
    }
}

#Preview {
    VoteListView()
        .environmentObject(GameViewModel())
}
