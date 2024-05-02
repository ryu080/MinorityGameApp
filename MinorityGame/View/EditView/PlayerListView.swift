//
//  CreatePlayerView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/28.
//

import SwiftUI

struct PlayerListView: View {
    @EnvironmentObject private var gameViewModel:GameViewModel
    @EnvironmentObject private var realmViewModel:RealmViewModel
    @EnvironmentObject private var alertViewModel:AlertViewModel
    @EnvironmentObject private var rootViewModel:RootViewModel

    @State var isShowCreatePlayerView:Bool = false
    @State var isShowGameCountView:Bool = false

    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0, alignment: .center), count: 4)

    @State var deleteUser:User?

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    VStack {
                        Spacer()
                        Text("問題数")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        HStack {
                            Spacer()
                            Button {
                                gameViewModel.gameCountDown()
                            } label: {
                                Image(systemName: "minus")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 40,height: 40)
                            .background(.mint.opacity(0.8))
                            .clipShape(Circle())                        
                            .overlay(
                                Circle()
                                    .stroke(Color.mint, lineWidth: 3)
                            )
                            Spacer()
                            Text("\(gameViewModel.game.maxGameCount)")
                                .font(.system(size: 75))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            Spacer()
                            Button {
                                gameViewModel.gameCountUp()
                            } label: {
                                Image(systemName: "plus")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 40,height: 40)
                            .background(.mint.opacity(0.8))
                            .clipShape(Circle())                        .overlay(
                                Circle()
                                    .stroke(Color.mint, lineWidth: 3)
                            )
                            Spacer()
                        }
                        Spacer()
                    }
                }
                Spacer()
                ZStack{
                    RoundedCorners(color: .white, tl: 20, tr: 20, bl: 0, br: 0)
                    VStack {
                        Spacer()
                        Group{
                            if gameViewModel.game.users.count < 12{
                                Button  {
                                    isShowCreatePlayerView.toggle()
                                } label: {
                                    Text("プレイヤー追加")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .tint(.white)
                                }
                                .frame(width: 300,height: 50)
                                .background(.mint.opacity(0.8))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.mint, lineWidth: 3)
                                )
                            } else {
                                Text("プレイヤー追加")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                    .frame(width: 300,height: 50)
                                    .background(.gray.opacity(0.8))
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 3)
                                    )
                            }
                        }
                        .padding(10)
                        Spacer()
                        ScrollView( .vertical) {
                            Spacer()
                            LazyVGrid(columns:columns) {
                                ForEach(gameViewModel.game.users){user in
                                    Button {
                                        deleteUser = user
                                        alertViewModel.deletePlayerAlert(name: user.name)
                                    } label: {
                                        PlayerView(playerImageData:user.imageData, name: user.name, backgroundColor: .mint,opacity: 0.3)
                                            .padding()
                                    }
                                }
                            }
                            .padding()
                            .background(.gray.opacity(0.2))
                            .cornerRadius(10)
                            Spacer()
                            Button {
                                gameViewModel.limitUserCount(root: rootViewModel, alert: alertViewModel,realm: realmViewModel)
                            } label: {
                                Text("ゲームスタート")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .tint(.white)
                            }
                            .frame(width: 200,height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(10)
                            .padding()
                            Spacer()
                        }.frame(width: UIScreen.main.bounds.width-20)
                    }
                }
                .frame(height:UIScreen.main.bounds.height/1.5)

            }
            .sheet(isPresented: $isShowCreatePlayerView, content: {
                CreatePlayerView()
            })
            .alert(isPresented: $alertViewModel.isShowAlert) {
                switch alertViewModel.alertType {
                case .success: 
                    return Alert(title: Text(alertViewModel.alertTitle),
                                 message: Text(alertViewModel.alertMessage),
                                 primaryButton: .cancel(Text("戻る")),
                                 secondaryButton: .default(Text("確認"),
                                                               action: {
                                        }))
                case .delete:
                    return Alert(title: Text(alertViewModel.alertTitle),
                                   message: Text(alertViewModel.alertMessage),
                                 primaryButton: .cancel(Text("戻る")),
                                 secondaryButton: .destructive(Text("削除"),
                                                               action: {
                        if let user = deleteUser{
                            gameViewModel.deleteUser(id: user.id)
                        }
                    }))
                case .error:
                    return Alert(title: Text(alertViewModel.alertTitle),
                                   message: Text(alertViewModel.alertMessage),
                                              dismissButton: .default(Text("OK"),
                                                                      action: {
                                        }))
                }
            }
            .edgesIgnoringSafeArea(.all)

        }
    }
}

#Preview {
    PlayerListView()
        .environmentObject(GameViewModel())
        .environmentObject(RealmViewModel())
        .environmentObject(AlertViewModel())
        .environmentObject(RootViewModel())
}
