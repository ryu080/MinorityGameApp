//
//  RuleGameView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct RuleGameView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("Unique 1")
                    .font(.system(size: 50))
                    .foregroundStyle(Color.white)
                    .fontWeight(.black)
                Text("ルール")
                    .font(.title2)
                    .foregroundStyle(Color.white)
                    .fontWeight(.black)
                ScrollView {
                    VStack {
                        VStack {
                            Text("Unique1は1番ユニークな人を決める")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundStyle(Color.white)
                            Text("価値観ゲームです")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(Color.white)
                        }
                        .padding(5)
                        .background(LinearGradient(gradient: Gradient(colors: [.blue, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(10)
                        Text("ゲームの流れ")
                            .font(.title3)
                            .fontWeight(.black)
                            .foregroundStyle(Color.mint)
                            .padding(5)
                        VStack(spacing:10){
                            Text("(1)制限時間内に2択のどちらに回答するか決めてください。")
                                .frame(width: UIScreen.main.bounds.width-60,alignment: .leading)
                            Text("(2)1人づつ順番にどちらかに回答する。")
                                .frame(width: UIScreen.main.bounds.width-60,alignment: .leading)
                            Text("(3)全員の回答が終わったら回答結果が表示されます。")
                                .frame(width: UIScreen.main.bounds.width-60,alignment: .leading)
                            Text("(4)少数派のプレイヤーは+1ポイントです。\n同数の場合は全員+0ポイントです。")
                                .frame(width: UIScreen.main.bounds.width-60,alignment: .leading)
                            Text("(5)ゲーム終了後、ポイントが一番多いプレイヤがUnique1です！！")
                                .frame(width: UIScreen.main.bounds.width-60,alignment: .leading)
                        }
                        .font(.headline)
                        .bold()
                        .foregroundStyle(Color.mint)
                        Text("※注意事項※")
                            .font(.title3)
                            .fontWeight(.black)
                            .foregroundStyle(.red)
                            .padding(5)
                        VStack(spacing:10){
                            Text("・嘘は付かず正直に答えましょう。")
                                .frame(width: UIScreen.main.bounds.width-60,alignment: .leading)
                            Text("・Unique1は複数人の場合があります。")
                                .frame(width: UIScreen.main.bounds.width-60,alignment: .leading)
                            Text("・価値観が違っても喧嘩などせず、楽しく遊びましょう！！")
                                .frame(width: UIScreen.main.bounds.width-60,alignment: .leading)
                        }
                        .font(.headline)
                        .bold()
                        .foregroundStyle(.red)
                    }.padding()
                }
                .frame(width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.height/2)
                .background(Color.white.opacity(1))
                .cornerRadius(20)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Text("閉じる")
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundStyle(Color.white)
                        .padding(10)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    RuleGameView()
}
