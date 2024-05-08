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
                        .modifier(FrameFitToDevices(iPhone: (width: 54, height: 72),
                                                    iPhoneSE: (width: 54, height: 72),
                                                    iPad: (width: 105, height: 140)))
                        .cornerRadius(7)
                        .scaledToFit()

                }else{
                    Image("person0")
                        .resizable()
                        .modifier(FrameFitToDevices(iPhone: (width: 54, height: 72),
                                                    iPhoneSE: (width: 54, height: 72),
                                                    iPad: (width: 105, height: 140)))
                        .cornerRadius(7)
                        .scaledToFit()
                }
                Spacer()
                Text(name)
                    .modifier(FrameFitToDevices(iPhone: (width: 69, height: nil),
                                                iPhoneSE: (width: 69, height: nil),
                                                iPad: (width: 120, height: nil)))
                    .modifier(TextFitToDevices(iPhone: 12, iPhoneSE: 12, iPad: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .lineLimit(1)
                Spacer()
            }
        }.modifier(FrameFitToDevices(iPhone: (width: 69, height: 92),
                                     iPhoneSE: (width: 69, height: 92),
                                     iPad: (width: 120, height: 160)))
    }
}

#Preview {
    PlayerView(playerImageData: nil, name: "プレイヤー1", backgroundColor: .mint, opacity: 0.3)
}
