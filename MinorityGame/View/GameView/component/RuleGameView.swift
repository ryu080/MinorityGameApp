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
        ZStack{
            Color.pennBlue.opacity(0.8)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Text("少数決ゲーム")
                    .font(.largeTitle)
                    .foregroundStyle(Color.champagne)
                    .fontWeight(.black)
                Text("ルール")
                    .font(.title)
                    .foregroundStyle(Color.champagne)
                    .fontWeight(.black)
                Spacer()
                ScrollView{
                    VStack{
                        Text("ゲームの流れ")
                            .font(.title3)
                            .fontWeight(.black)
                            .foregroundStyle(Color.champagne)
                            .padding(5)
                        Text("1.出題者に選ばれたプレイヤーがお題を出す。\n2.制限時間内にYES/NOどちらに投票するか相談する。\n3.順番にYES/NOどちらかで必ず回答する。\n4.少数派のプレイヤーは+1ポイント\n　多数派のプレイヤーは-1ポイント\n5.1~10ゲーム繰り返し、\n　ポイントが多いプレイヤーの勝利。")
                            .padding(.trailing)
                            .font(.headline)
                            .bold()
                            .foregroundStyle(Color.champagne)
                        Text("※注意事項※")
                            .font(.title3)
                            .fontWeight(.black)
                            .foregroundStyle(.red)
                            .padding(5)
                        Text("・お題はyes/noで答えられるものにする。\n・投票は嘘をついてもよい。\n・YES/NOが同数の場合、0ポイント")
                            .padding(.trailing)
                            .font(.headline)
                            .bold()
                            .foregroundStyle(.red)
                    }.padding()
                }
                .frame(width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.height/2)
                .background(Color.pennBlue.opacity(1))
                .cornerRadius(20)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Text("閉じる")
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundStyle(Color.champagne)
                        .padding(10)
                        .background(Color.pennBlue)
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
