//
//  WinnerView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/10.
//

import SwiftUI

struct WinnerView: View {
    var winnerUser:[User]
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0, alignment: .center), count: 1)
    var body: some View {
        ZStack {
            Color.clear
            VStack {
                Spacer()
                Text("🎉You are unique🎉")
                    .font(.system(size: 38))
                    .fontWeight(.black)
                    .foregroundStyle(Color.yellow)
                    .frame(width: UIScreen.main.bounds.width)
                Spacer()
                ScrollView( .vertical) {
                    Spacer()
                    LazyVGrid(columns:columns) {
                        ForEach(winnerUser){user in
                            VStack{
                                PlayerView(playerImageData:user.imageData, name: user.name, backgroundColor: Color.electricBlue,opacity: 1)
                                Text("\(user.totalPoints)")
                                    .fontWeight(.black)
                                    .foregroundStyle(.white)
                                    .frame(width: 80)
                                    .background(.yellow)
                                    .cornerRadius(10)
                                    .padding(5)
                            }.scaleEffect(x: 2.8, y: 2.8)
                                .frame(width: 300,height: 450)
                        }
                    }
                    .padding()
                }
                .frame(height: 450)
                .background(.black.opacity(0.2))
                .cornerRadius(10)
            }
        }
    }
}

#Preview {
    WinnerView(winnerUser: [User(id: 0, imageData: nil, name: "小粋", point: 1, totalPoints: 6, question: 2)])
    .environmentObject(GameViewModel())
}
