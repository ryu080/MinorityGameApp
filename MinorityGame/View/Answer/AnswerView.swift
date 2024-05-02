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
                    .font(.system(size: 50))
                    .foregroundStyle(.white)
                    .fontWeight(.black)
                    .padding()
                    .background(color)
                    .cornerRadius(10)
                Text("\(count)")
                    .font(.system(size: 150))
                    .foregroundStyle(.white)
                    .fontWeight(.black)
                Spacer()
            }
        }
        .onAppear(){

        }
    }
}

#Preview {
    AnswerView(choice: "イヌ派", count: 2, color: .electricBlue)
}
