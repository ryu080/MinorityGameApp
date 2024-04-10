//
//  QuestionerView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var gameViewModel:GameViewModel

    @State var isQuestionView:Bool = false
    @State var user:User = User(id: 0, name: "",point: 0, totalPoints: 0, question: 0)
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                Text("出題者は...")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.red)
                    .padding(10)
                if isQuestionView {
                    Text("\(user.name)さん")
                        .font(.largeTitle)
                    ZStack{
                        TextEditor(text: $gameViewModel.questionText)
                            .scrollContentBackground(Visibility.hidden)
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(width: UIScreen.main.bounds.width-20, height:150)
                            .border(.black, width: 5)
                            .overlay(alignment: .center) {
                                // 未入力の時、プレースホルダーを表示
                                if gameViewModel.questionText.isEmpty {
                                    Text("出題者はYES/NOで答えられる質問をしてください。")
                                        .font(.title)
                                        .bold()
                                        .allowsHitTesting(false)
                                        .foregroundColor(Color(uiColor: .placeholderText))
                                        .padding(6)
                                }
                            }
                    }
                    Button {
                        gameViewModel.gameView = .discussionView
                    } label: {
                        Text("出題する")
                    }
                }else{
                    Spacer()
                    Button {
                        user = gameViewModel.chooseQuestioner()
                        isQuestionView = true
                    } label: {
                        Text("表示する")
                            .font(.title)
                            .bold()
                            .foregroundStyle(.white)
                            .padding(10)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    QuestionView()
        .environmentObject(GameViewModel())
        .environmentObject(RealmViewModel())
}
