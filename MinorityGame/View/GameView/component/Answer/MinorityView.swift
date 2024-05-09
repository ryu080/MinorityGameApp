//
//  MinorityView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/22.
//

import SwiftUI

struct MinorityView: View {
    @EnvironmentObject private var rootViewModel:RootViewModel
    let winner:String
    let backgroundColor:Color
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("Uniqueは...")
                    .modifier(TextFitToDevices(iPhone: 40, iPhoneSE: 30, iPad: 60))
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)
                Spacer()
                Text(winner)
                    .modifier(TextFitToDevices(iPhone: 50, iPhoneSE: 40, iPad: 80))
                    .foregroundStyle(Color.white)
                    .fontWeight(.black)
                Image("Cracker")
                    .resizable()
                    .modifier(FrameFitToDevices(iPhone: (width: 350, height: 200),
                                                iPhoneSE: (width: 294, height: 168),
                                                iPad: (width: 595, height: 340)))
                Spacer()
                Button {
                    rootViewModel.loadingView = false
                    rootViewModel.nextGameView(nextView: .resultGameView)
                } label: {
                    Text("次へ")
                        .modifier(TextFitToDevices(iPhone: 23, iPhoneSE: 20, iPad: 50))
                        .fontWeight(.black)
                        .foregroundStyle(Color.white)
                }
                .modifier(FrameFitToDevices(iPhone: (width: 300, height: 50),
                                            iPhoneSE: (width: 230, height: 40),
                                            iPad: (width: 600, height: 100)))
                .background(.white.opacity(0.2))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 3)
                )

                Spacer()
            }
        }
        .onAppear(){

        }
    }
}

#Preview {
    MinorityView(winner: "ネコ派", backgroundColor: Color.electricBlue)
        .environmentObject(RootViewModel())
}
