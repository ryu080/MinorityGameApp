//
//  ResultView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var gameViewModel:GameViewModel
    @State var yesUsers:[User] = []
    @State var noUsers:[User] = []
    @State var winer:String = ""

    var body: some View {
        ZStack{
            Color.pennBlue
            VStack{
                Spacer()
                Text(winer)
                    .font(.largeTitle)
                    .frame(width: UIScreen.main.bounds.width,height: 50)
                    .fontWeight(.black)
                    .foregroundStyle(Color.pennBlue)
                    .background(Color.champagne)
                Spacer()
                List{
                    Section{
                        ForEach(yesUsers){user in
                            HStack{
                                Text(user.name)
                                    .font(.title3)
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.pennBlue)
                                Spacer()
                                if user.question == 1{
                                    Text("YES")
                                        .font(.title3)
                                        .fontWeight(.black)
                                        .foregroundStyle(.blue)
                                }else if user.question == 2 {
                                    Text("NO")
                                        .font(.title3)
                                        .fontWeight(.black)
                                        .foregroundStyle(.red)
                                }
                                Text("\(user.point)")
                                    .font(.title3)
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.pennBlue)
                                Text("合計\(user.totalPoints)P")
                                    .font(.title3)
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.pennBlue)
                            }
                            .padding(10)
                            .listRowBackground(Color.champagne)
                        }
                    }header: {
                        HStack{
                            Text("YES")
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundStyle(.blue)
                            Text("\(yesUsers.count)人")
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundStyle(Color.champagne)
                            Spacer()
                        }
                    }
                    Section{
                        ForEach(noUsers){user in
                            HStack{
                                Text(user.name)
                                    .font(.title3)
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.pennBlue)
                                Spacer()
                                if user.question == 1{
                                    Text("YES")
                                        .font(.title3)
                                        .fontWeight(.black)
                                        .foregroundStyle(.blue)
                                }else if user.question == 2 {
                                    Text("NO")
                                        .font(.title3)
                                        .fontWeight(.black)
                                        .foregroundStyle(.red)
                                }
                                Text("\(user.point)")
                                    .font(.title3)
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.pennBlue)
                                Text("合計\(user.totalPoints)P")
                                    .font(.title3)
                                    .fontWeight(.black)
                                    .foregroundStyle(Color.pennBlue)
                            }
                            .padding(10)
                            .listRowBackground(Color.champagne)
                        }
                    }header: {
                        HStack{
                            Text("NO")
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundStyle(.red)
                            Text("\(noUsers.count)人")
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundStyle(Color.champagne)
                            Spacer()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .frame(height: UIScreen.main.bounds.height/2)
                Spacer()
            }
            .onAppear(){
                self.winer = gameViewModel.resultVote()
                self.yesUsers = gameViewModel.yesUser()
                self.noUsers = gameViewModel.noUser()
            }
        }
    }
}

#Preview {
    ResultView()
        .environmentObject(GameViewModel())
}
