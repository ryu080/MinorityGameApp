//
//  PlayerView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/28.
//

import SwiftUI

struct PlayerView: View {
    let playerImage:Image
    let name:String
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(10)
                .foregroundColor(.mint.opacity(0.3))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.mint, lineWidth: 3)
                )
            VStack {
                Spacer()
                playerImage
                    .resizable()
                    .frame(width: 50,height: 70)
                    .scaledToFit()
                Spacer()
                Text(name)
                    .frame(width: 75)
                    .font(.system(size: 12))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .lineLimit(1)
                Spacer()
            }
        }.frame(width: 75,height: 125)
    }
}

#Preview {
    PlayerView(playerImage: Image(systemName:"person"), name: "プレイヤー1")
}
