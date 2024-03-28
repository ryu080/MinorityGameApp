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
            VStack{
                Spacer()
                Text("少数決ゲーム")
                    .font(.largeTitle)
                    .foregroundStyle(.red)
                    .bold()
                    .padding(.bottom,50)
                ScrollView{
                    VStack{
                        Text("ゲームの流れ")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.white)
                            .padding(5)
                        Text("1.出題者に選ばれたプレイヤーがお題を出す。\n2.制限時間内にYES/NOどちらに投票するか相談する。\n3.順番にYES/NOどちらかで必ず回答する。\n4.少数派のプレイヤーは+1ポイント\n　多数派のプレイヤーは-1ポイント\n5.1~10ゲーム繰り返し、\n　ポイントが多いプレイヤーの勝利。")
                            .padding(.trailing)
                            .font(.headline)
                            .bold()
                            .foregroundStyle(.white)
                        //\n（yes/noで答えられるもの）\n嘘をついても良い話し合いok
                        Text("※注意事項※")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.white)
                            .padding(5)
                        Text("・お題はyes/noで答えられるものにする。\n・投票は嘘をついてもよい。\n・YES/NOが同数の場合、やり直し\n・ポイントの合計が-2になったプレイヤーは脱落")
                            .padding(.trailing)
                            .font(.headline)
                            .bold()
                            .foregroundStyle(.white)
                    }
                }
                .frame(width: UIScreen.main.bounds.width-20, height: UIScreen.main.bounds.height/2)
                .background(.red)
                .cornerRadius(20)
                Button {
                    dismiss()
                } label: {
                    Text("閉じる")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                        .padding(10)
                        .background(.red)
                        .cornerRadius(10)
                }.padding(.top,50)
                Spacer()
            }
        }
    }
}

#Preview {
    RuleGameView()
}
