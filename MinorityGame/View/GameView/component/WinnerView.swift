//
//  WinnerView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/10.
//

import SwiftUI

struct WinnerView: View {
    var winnerUser:[User]

    var body: some View {
        ZStack{
            Color.pennBlue
            VStack{
                Text("🎉Winner🎉")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundStyle(Color.champagne)
                List(winnerUser){user in
                    HStack{
                        Text(user.name)
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundStyle(Color.pennBlue)
                        Spacer()
                        Text("\(user.totalPoints)P")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundStyle(Color.pennBlue)
                    }.padding(10)
                        .listRowBackground(Color.champagne)
                }
                .frame(height: UIScreen.main.bounds.height/2)
                .scrollContentBackground(.hidden)
            }
        }
    }
}

#Preview {
    WinnerView( winnerUser: [User(id: 0, name: "小粋", point: 1, totalPoints: 6, question: 2)])
        .environmentObject(GameViewModel())
}
