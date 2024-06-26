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
    @EnvironmentObject private var questionViewModel:QuestionViewModel
    @EnvironmentObject private var alertViewModel:AlertViewModel
    @EnvironmentObject private var rootViewModel:RootViewModel
    @EnvironmentObject private var genreViewModel:GenreViewModel

    @State private var selection = 0
    @State private var isShowCreatePlayerView:Bool = false

    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0, alignment: .center), count: 4)

    @State var deleteUser:User?

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                TabView(selection: $selection) {
                    VStack{
                        Text("問題数")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                            .frame(width: 250,height: 50)
                            .background(.white)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.mint, lineWidth: 1)
                            )
                            .shadow(radius: 5)
                            .padding(.bottom,5)
                        HStack{
                            Spacer()
                            Image(systemName: "arrowtriangle.backward")
                                .font(.system(size: 50))
                                .foregroundStyle(.white.opacity(0.5))
                            Spacer()
                            GameCountView()
                            Spacer()
                            Button {
                                withAnimation {
                                    selection = 1
                                }
                            } label: {
                                Image(systemName: "arrowtriangle.forward.fill")
                                    .font(.system(size: 50))
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            Spacer()
                        }
                    }.tag(0)
                    VStack{
                        Text("ジャンル")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                            .frame(width: 250,height: 50)
                            .background(.white)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.mint, lineWidth: 1)
                            )
                            .shadow(radius: 5)
                            .padding(.bottom,5)
                        HStack{
                            Spacer()
                            Button {
                                withAnimation {
                                    selection = 0
                                }
                            } label: {
                                Image(systemName: "arrowtriangle.backward.fill")
                                    .font(.system(size: 50))
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            Spacer()
                            GameGenreView()
                            Spacer()
                            Image(systemName: "arrowtriangle.forward")
                                .font(.system(size: 50))
                                .foregroundStyle(.white.opacity(0.5))
                            Spacer()
                        }
                    }.tag(1)
                }
                .tabViewStyle(.page)
                .frame(height: 350)
                Spacer()
                ZStack{
                    RoundedCorners(color: .white, tl: 50, tr: 50, bl: 0, br: 0)
                        .compositingGroup()
                        .shadow(radius: 5)
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
                                if gameViewModel.limitUserCount(genre: genreViewModel.genreName) == (true,true) {
                                    alertViewModel.gameStartAlert(gameCount: gameViewModel.game.maxGameCount, genre: genreViewModel.genreName!)
                                }else if gameViewModel.limitUserCount(genre: genreViewModel.genreName) == (false,true){
                                    alertViewModel.playerCountAlert()
                                }else{
                                    alertViewModel.genreAlert()
                                }
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
                                 secondaryButton: .default(Text("スタート"),
                                                           action: {
                        gameViewModel.game.questions = questionViewModel.setUseQuestionsRealm(maxGameCount: gameViewModel.game.maxGameCount, genre: genreViewModel.genreName!)
                        realmViewModel.setGame(game: gameViewModel.game,primaryKey: 0)
                        realmViewModel.setGame(game: gameViewModel.game,primaryKey: 1)
                        rootViewModel.nextGameView(nextView: .discussionView)
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
        .environmentObject(QuestionViewModel())
        .environmentObject(AlertViewModel())
        .environmentObject(RootViewModel())
        .environmentObject(GenreViewModel())
}
