//
//  CreateQuestionView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/22.
//

import SwiftUI

struct CreateQuestionView: View {
    @State var questionText:String = ""
    @State var choice1:String = ""
    @State var choice2:String = ""
    var body: some View {
        ZStack{
            Color.pennBlue
                .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                ZStack {
                    TextEditor(text: $questionText)
                        .scrollContentBackground(Visibility.hidden)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
                        .foregroundColor(Color.pennBlue)
                        .frame(width: UIScreen.main.bounds.width-20, height:150)
                        .background(Color.champagne)
                        .cornerRadius(20)
                        .overlay(alignment: .center) {
                            // 未入力の時、プレースホルダーを表示
                            if questionText.isEmpty {
                                Text("問題文は2択で答えられるものにしてください。（52文字以内）")
                                    .font(.title2)
                                    .bold()
                                    .allowsHitTesting(false)
                                    .foregroundColor(Color(uiColor: .placeholderText))
                                    .padding(6)
                            }
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.amaranthPurple, lineWidth: 5)
                        }
                }
                Spacer()
                HStack{
                    Spacer()
                    TextField("",text: $choice1){

                    }
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.width/2.5,height: 75)
                    .background(Color.electricBlue.opacity(0.7))
                    .cornerRadius(10)
                    Spacer()
                    TextField("",text: $choice2){

                    }
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.width/2.5,height: 75)
                    .background(Color.bittersweet.opacity(0.7))
                    .cornerRadius(10)
                    Spacer()
                }
                Spacer()
                Button {
                    //
                } label: {
                    Text("作成する")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundStyle(Color.white)
                }
                .padding(15)
                .background(Color.green)
                .cornerRadius(10)
                Spacer()
            }
        }
    }
}

#Preview {
    CreateQuestionView()
}
