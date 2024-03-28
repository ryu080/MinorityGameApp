//
//  EditGameView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct EditGameView: View {
    @EnvironmentObject var viewModel:GameViewModel
    @State var isShowAlert = false
    @State var isStringCount = false
    @State var inputText = ""

    var body: some View {
        ZStack{
            VStack{
                VStack(){
                    Text("ゲーム設定")
                        .font(.title2)
                        .bold()
                    HStack{
                        TextField("プレイヤー名（12文字以内）", text: $inputText)
                            .textFieldStyle(.roundedBorder)
                        Spacer()
                        Button {
                            if 0 < inputText.count && inputText.count <= 12 {
                                viewModel.addUser(name: inputText)
                                inputText = ""
                            }else {
                                isStringCount.toggle()
                            }
                        } label: {
                            Text("追加")
                                .bold()
                                .foregroundStyle(.white)
                        }
                        .padding(7)
                        .background(.blue)
                        .cornerRadius(5)
                        .alert("注意", isPresented: $isStringCount) {
                        } message: {
                            if inputText == ""{
                                Text("プレイヤー名が入力されていません。\n1~12文字以内で入力してください。")
                            }else{
                                Text("プレイヤー名は\n12文字以内で入力してください")
                            }
                        }

                    }
                    HStack{
                        Text("人数: \(viewModel.users.count)")
                            .bold()
                        Spacer()
                        Text("ゲーム数: \(viewModel.maxGameCount)")
                            .bold()
                            .padding(5)
                        Button("-"){viewModel.subGameCount()}
                            .font(.title)
                            .frame(width: 35 ,height: 35)
                            .foregroundColor(.white)
                            .background(.red)
                            .cornerRadius(5)

                        Button("+"){viewModel.addGameCount()}
                            .font(.title)
                            .frame(width: 35 ,height: 35)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(5)
                    }
                    Text("参加プレイヤー")
                        .font(.title3)
                        .bold()
                    List(viewModel.users){user in
                        HStack{
                            Text(user.name)
                                .font(.title2)
                                .bold()
                                .frame(height: 40)
                            Spacer()
                            Button(action: {
                                //削除機能
                                viewModel.deleteUser(id: user.id)
                            }, label: {
                                Image(systemName: "trash.fill")
                                    .font(.title3)
                                    .foregroundColor(.red)
                            })
                        }
                        .listRowBackground(Color.gray)
                    }
                    .frame(height: UIScreen.main.bounds.height/2)
                    .scrollContentBackground(.hidden)
                    .cornerRadius(20)
                    Button {
                        if viewModel.users.count == 0 {

                        }else {
                            viewModel.setView = false
                            viewModel.mainOrGameView = true
                        }
                    } label: {
                        Text("次へ")
                            .font(.title)
                            .bold()
                            .foregroundStyle(.white)
                    }
                    .frame(width: 100,height: 50)
                    .background(.blue)
                    .cornerRadius(10)
                    .alert("プレイヤーがいません。", isPresented: $isShowAlert) {
                    } message: {
                        Text("プレイヤーを追加してください\n※最低3人登録してください")
                    }
                }
                Spacer()
            }
            .padding(10)
        }.onAppear(){
            viewModel.continuationGame()
        }
    }
}
#Preview {
    EditGameView()
        .environmentObject(GameViewModel())
}
