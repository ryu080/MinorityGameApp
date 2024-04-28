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
            Color.pennBlue
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(choice)
                    .font(.system(size: 50))
                    .foregroundStyle(color)
                    .fontWeight(.black)
                Text("\(count)")
                    .font(.system(size: 150))
                    .foregroundStyle(.white)
                    .fontWeight(.black)
            }
        }
        .onAppear(){

        }
    }
}

#Preview {
    AnswerView(choice: "イヌ派", count: 2, color: .bittersweet)
}
