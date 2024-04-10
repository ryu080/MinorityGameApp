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
        VStack{
            Text("Winner")
                .font(.largeTitle)
            List(winnerUser){user in
                HStack{
                    Text(user.name)
                        .font(.largeTitle)
                    Spacer()
                    Text("\(user.totalPoints)")
                        .font(.largeTitle)
                }.padding(20)
            }
        }
    }
}

#Preview {
    WinnerView( winnerUser: [])
        .environmentObject(GameViewModel())
}
