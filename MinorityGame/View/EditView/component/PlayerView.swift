//
//  PlayerView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/28.
//

import SwiftUI

struct PlayerView: View {
    
    let playerImageData:Data?
    let name:String
    let backgroundColor:Color
    let opacity:Double

    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(10)
                .foregroundColor(backgroundColor.opacity(opacity))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(backgroundColor, lineWidth: 3)
                )
            VStack {
                Spacer()
                if let playerImageData, let uiImage = UIImage(data: playerImageData) {
                            Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 60,height: 80)
                        .cornerRadius(7)
                        .scaledToFit()

                }else{
                    Image("person_cat")
                        .resizable()
                        .frame(width: 60,height: 80)
                        .cornerRadius(7)
                        .scaledToFit()
                }
                Spacer()
                Text(name)
                    .frame(width: 75)
                    .font(.system(size: 12))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .lineLimit(1)
                Spacer()
            }
        }.frame(width: 75,height: 100)
    }
}

#Preview {
    PlayerView(playerImageData: nil, name: "プレイヤー1", backgroundColor: .mint, opacity: 0.3)
}
