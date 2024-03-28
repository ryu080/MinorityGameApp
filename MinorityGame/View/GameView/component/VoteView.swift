//
//  VoteView.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import SwiftUI

struct VoteView: View {
    @EnvironmentObject var viewModel:GameViewModel
    @Environment(\.dismiss) var dismiss
    
    var user:User
    var body: some View {
        ZStack{
            VStack{
                ZStack{
                    Text(viewModel.questionText)
                        .font(.title)
                        .bold()
                        .frame(alignment: .center)
                        .foregroundStyle(.black)
                }
                HStack{
                    Spacer()
                    Button("YES"){
                        viewModel.questionUser(id: user.id, question: 1)
                        dismiss()
                    }.font(.title)
                        .bold()
                    Spacer()
                    Button("NO"){
                        viewModel.questionUser(id: user.id, question: 2)
                        dismiss()
                    }
                    .font(.title)
                    .bold()
                    .foregroundColor(.red)
                    Spacer()
                }
                .navigationTitle("\(user.name)さんの回答")
            }
        }
    }
}

#Preview {
    VoteView(user: User(id: 1, name: "サンプル太", point: 0, question: 0)).environmentObject(GameViewModel())
}
