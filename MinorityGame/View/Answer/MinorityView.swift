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
                Text("少数派は...")
                    .font(.largeTitle)
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)
                    .padding(.vertical,100)
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
                .background(Color.mint)
                .cornerRadius(10)
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
