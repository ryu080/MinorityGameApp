//
//  CreatePlayerView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/28.
//

import SwiftUI

struct CreatePlayerView: View {
    @EnvironmentObject var gameViewModel:GameViewModel
    @EnvironmentObject var alertViewModel:AlertViewModel
    @State var name:String = ""
    var body: some View {
        ZStack {
            VStack {
                
                HStack {
                    Spacer()
                    TextField("プレイヤー名（8文字以内）", text: $name)
                        .textFieldStyle(.roundedBorder)
                        .bold()
                        .frame(width: UIScreen.main.bounds.width-80)
                    Spacer()
                }
                Button {
                    if 0 < name.count && name.count <= 8 {
                        gameViewModel.createUser(name: name)
                        //inputText = "" が反応しないため追加
                        if !self.name.isEmpty {
                            self.name = self.name + " "
                            Task { @MainActor in
                                self.name = ""
                            }
                        }
                    } else {
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
        }
    }
}

#Preview {
    CreatePlayerView()
        .environmentObject(GameViewModel())
        .environmentObject(AlertViewModel())
}
