//
//  AnswerView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/22.
//

import SwiftUI

struct AnswerView: View {

    let choice:String
    let count:Int
    let color:Color

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text(choice)
                    .modifier(TextFitToDevices(iPhone: 50, iPhoneSE: 40, iPad: 80))
                    .foregroundStyle(.white)
                    .fontWeight(.black)
                    .padding(.horizontal,10)
                    .padding(10)
                    .background(color)
                    .cornerRadius(10)
                Text("\(count)")
                    .modifier(TextFitToDevices(iPhone: 150, iPhoneSE: 130, iPad: 200))
                    .foregroundStyle(.white)
                    .fontWeight(.black)
                Spacer()
            }
        }
    }
}

#Preview {
    AnswerView(choice: "イヌ派", count: 2, color: .electricBlue)
}
