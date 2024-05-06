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
                    .font(.largeTitle)
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)
                Spacer()
                Text(winner)
                    .font(.system(size: 50))
                    .foregroundStyle(Color.white)
                    .fontWeight(.black)
                Image("Cracker")
                    .resizable()
                    .frame(width: 350, height: 200)
                Spacer()
                Button {
                    rootViewModel.loadingView = false
                    rootViewModel.nextGameView(nextView: .resultGameView)
                } label: {
                    Text("次へ")
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundStyle(Color.white)
                }
                .frame(width: 100,height: 30)
                .padding(10)
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
