//
//  QuestionerView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

//import SwiftUI
//
//struct QuestionView: View {
//    @EnvironmentObject private var rootViewModel:RootViewModel
//    @EnvironmentObject private var gameViewModel:GameViewModel
//    @EnvironmentObject private var alertViewModel:AlertViewModel
//
//    @State private var isQuestionView:Bool = false
//    @State private var user:User?
//
//    var body: some View {
//        ZStack {
//            Color.pennBlue
//                .edgesIgnoringSafeArea(.all)
//            VStack {
//                Spacer()
//                Text("出題者は...")
//                    .font(.largeTitle)
//                    .fontWeight(.black)
//                    .foregroundStyle(Color.champagne)
//                    .padding(10)
//                Group {
//                    if isQuestionView {
//                        Text("\(user!.name)さん")
//                            .font(.largeTitle)
//                            .fontWeight(.black)
//                            .foregroundStyle(Color.champagne)
//                        Spacer()
//                        ZStack {
//                            TextEditor(text: $gameViewModel.questionText)
//                                .scrollContentBackground(Visibility.hidden)
//                                .font(.title)
//                                .multilineTextAlignment(.center)
//                                .fontWeight(.bold)
//                                .foregroundColor(Color.pennBlue)
//                                .frame(width: UIScreen.main.bounds.width-20, height:150)
//                                .background(Color.champagne)
//                                .cornerRadius(20)
//                                .overlay(alignment: .center) {
//                                    // 未入力の時、プレースホルダーを表示
//                                    if gameViewModel.questionText.isEmpty {
//                                        Text("出題者はYES/NO\nで答えられる質問をしてください。\n※52文字以内")
//                                            .font(.title2)
//                                            .bold()
//                                            .allowsHitTesting(false)
//                                            .foregroundColor(Color(uiColor: .placeholderText))
//                                            .padding(6)
//                                    }
//                                    RoundedRectangle(cornerRadius: 20)
//                                        .stroke(Color.amaranthPurple, lineWidth: 5)
//                                }
//                        }
//                        Spacer()
//                        Button {
//                            alertViewModel.questionTextAlert(text: gameViewModel.questionText)
//                        } label: {
//                            Text("出題する")
//                                .font(.largeTitle)
//                                .fontWeight(.black)
//                                .foregroundStyle(Color.pennBlue)
//                        }
//                        .padding(15)
//                        .background(Color.champagne)
//                        .cornerRadius(10)
//                        Spacer()
//                    } else {
//                        Spacer()
//                        ProgressView()
//                            .scaleEffect(x: 3, y: 3, anchor: .center)
//                            .progressViewStyle(CircularProgressViewStyle(tint: Color.amaranthPurple))
//                        Spacer()
//                        Button {
//                            user = gameViewModel.chooseQuestioner()
//                            isQuestionView = true
//                        } label: {
//                            Text("表示する")
//                                .font(.largeTitle)
//                                .fontWeight(.black)
//                                .foregroundStyle(Color.pennBlue)
//                        }
//                        .padding(15)
//                        .background(Color.champagne)
//                        .cornerRadius(10)
//                    }
//                }
//                Spacer()
//            }
//        }
//        .alert(alertViewModel.alertTitle, isPresented: $alertViewModel.isShowAlert) {
//            if alertViewModel.alertType == .success {
//                Button("戻る",role: .cancel){}
//                Button("OK"){
//                    rootViewModel.gameView = .discussionView
//                }
//            }
//        } message: {
//            Text(alertViewModel.alertMessage)
//        }
//    }
//}
//
//#Preview {
//    QuestionView()
//        .environmentObject(RootViewModel())
//        .environmentObject(GameViewModel())
//        .environmentObject(RealmViewModel())
//        .environmentObject(AlertViewModel())
//}
