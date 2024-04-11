//
//  EditGameView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct EditGameView: View {
    @EnvironmentObject var gameViewModel:GameViewModel
    @EnvironmentObject var realmViewModel:RealmViewModel
    @EnvironmentObject var alertViewModel:AlertViewModel

    @State var name = ""

    var body: some View {
        ZStack{
            Color.pennBlue
                .edgesIgnoringSafeArea(.all)
            VStack{
                VStack(){
                    Text("ゲーム設定")
                        .font(.title2)
                        .fontWeight(.black)
                        .bold()
                        .foregroundStyle(Color.champagne)
                    HStack{
                        Text("人数: \(gameViewModel.game.users.count)")
                            .fontWeight(.black)
                            .bold()
                            .foregroundStyle(Color.champagne)
                        Spacer()
                        Text("ゲーム数: \(gameViewModel.game.maxGameCount)")
                            .fontWeight(.black)
                            .bold()
                            .foregroundStyle(Color.champagne)
                            .padding(5)
                        Button {
                            gameViewModel.addGameCount()
                        } label: {
                            Image(systemName: "plus")
                                .font(.title3)
                                .bold()
                        }
                        .frame(width: 30 ,height: 30)
                        .background(Color.champagne)
                        .cornerRadius(5)
                        Button {
                            gameViewModel.subGameCount()
                        } label: {
                            Image(systemName: "minus")
                                .font(.title3)
                                .foregroundStyle(.red)
                                .bold()
                        }
                        .frame(width: 30 ,height: 30)
                        .background(Color.champagne)
                        .cornerRadius(5)
                    }
                    Text("参加プレイヤー")
                        .font(.title3)
                        .fontWeight(.black)
                        .bold()
                        .foregroundStyle(Color.champagne)
                    HStack{
                        TextField("プレイヤー名（8文字以内）", text: $name)
                            .textFieldStyle(.roundedBorder)
                            .bold()
                        Spacer()
                        Button {
                            if 0 < name.count && name.count <= 8 {
                                gameViewModel.addUser(name: name)

                                //inputText = "" が反応しないため追加
                                if !self.name.isEmpty {
                                    self.name = self.name + " "
                                    Task { @MainActor in
                                        self.name = ""
                                    }
                                }
                            }else{
                                alertViewModel.playerNameAlert(name: name)
                            }
                        } label: {
                            Text("追加")
                                .bold()
                                .foregroundStyle(Color.pennBlue)
                        }
                        .padding(7)
                        .background(Color.champagne)
                        .cornerRadius(5)
                    }

                    List(gameViewModel.game.users.reversed()){user in
                        HStack{
                            Text(user.name)
                                .font(.title2)
                                .fontWeight(.black)
                                .foregroundStyle(Color.pennBlue)
                            Spacer()
                            Button(action: {
                                //削除機能
                                gameViewModel.deleteUser(id: user.id)
                            }, label: {
                                Image(systemName: "trash.fill")
                                    .font(.title3)
                                    .foregroundColor(.red)
                            })
                            .buttonStyle(PlainButtonStyle())
                        }.padding(10)
                        .listRowBackground(Color.champagne)
                    }
                    .frame(height: UIScreen.main.bounds.height/2)
                    .scrollContentBackground(.hidden)
                    Button {
                        if gameViewModel.game.users.count < 3 {
                            alertViewModel.playerCountAlert()
                        }else {
                            realmViewModel.createGame(game: gameViewModel.game)
                            gameViewModel.rootView = .gameView
                            gameViewModel.editView = .startGameView
                        }
                    } label: {
                        Text("次へ")
                            .font(.title)
                            .bold()
                            .foregroundStyle(Color.pennBlue)
                    }
                    .frame(width: 100,height: 50)
                    .background(Color.champagne)
                    .cornerRadius(10)
                }
                Spacer()
            }
            .padding(10)
            .alert(alertViewModel.alertTitle, isPresented: $alertViewModel.isShowAlert) {
            } message: {
                Text(alertViewModel.alertMessage)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
#Preview {
    EditGameView()
        .environmentObject(GameViewModel())
        .environmentObject(RealmViewModel())
        .environmentObject(AlertViewModel())
}
