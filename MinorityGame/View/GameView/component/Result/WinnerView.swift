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
                    .modifier(TextFitToDevices(iPhone: 38, iPhoneSE: 34, iPad: 50))
                    .fontWeight(.black)
                    .foregroundStyle(Color.yellow)
                    .frame(width: UIScreen.main.bounds.width)
                Spacer()
                ScrollView( .vertical) {
                    LazyVGrid(columns:columns) {
                        ForEach(winnerUser){user in
                            VStack{
                                PlayerView(playerImageData:user.imageData, name: user.name, backgroundColor: Color.mint,opacity: 0.5)
                                Text("\(user.totalPoints)")
                                    .fontWeight(.black)
                                    .foregroundStyle(.white)
                                    .modifier(FrameFitToDevices(iPhone: (width: 69, height: nil),
                                                                iPhoneSE: (width: 69, height: nil),
                                                                iPad: (width: 120, height: nil)))
                                    .background(.yellow)
                                    .cornerRadius(10)
                                    .padding(10)
                            }
                            .scaleEffect(x: 2, y: 2)
                            .modifier(FrameFitToDevices(iPhone: (width: 180, height: 220),
                                                         iPhoneSE: (width: 180, height: 220),
                                                         iPad: (width: 260, height: 380)))
                        }
                        .padding(.vertical,10)
                    }
                }
                .modifier(FrameFitToDevices(iPhone: (width: 350, height: 200),
                                             iPhoneSE: (width: 320, height: 170),
                                             iPad: (width: 800, height: 800)))
                .background(.white.opacity(0.8))
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
