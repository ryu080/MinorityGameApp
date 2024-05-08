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
                .edgesIgnoringSafeArea(.all)
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
                                PlayerView(playerImageData:user.imageData, name: user.name, backgroundColor: Color.mint,opacity: 0.5)
                                Text("\(user.totalPoints)")
                                    .fontWeight(.black)
                                    .foregroundStyle(.white)
                                    .frame(width: 80)
                                    .background(.yellow)
                                    .cornerRadius(10)
                                    .padding(5)
                            }
                            .scaleEffect(x: 2, y: 2)
                            .frame(width:190, height: 300)
                        }
                    }
                    .padding()
                }
                .frame(width: UIScreen.main.bounds.width-20,height: 300)
                .background(.black.opacity(0.2))
                .cornerRadius(10)
                Spacer()
            }
        }
    }
}

#Preview {
    WinnerView(winnerUser: [User(id: 0, imageData: nil, name: "小粋", point: 1, totalPoints: 6, question: 2)])
    .environmentObject(GameViewModel())
}
