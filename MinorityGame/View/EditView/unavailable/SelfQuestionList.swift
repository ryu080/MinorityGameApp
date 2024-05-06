//
//  SelfQuestionList.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/22.
//

import SwiftUI

struct SelfQuestionList: View {
    @StateObject var questionViewModel = QuestionViewModel()
    @EnvironmentObject var realmViewModel:RealmViewModel
    var body: some View {
        NavigationView{
            List(questionViewModel.selfQuestions(realm: realmViewModel)){selfQuestion in
                Text(selfQuestion.text)
                HStack{
                    Text(selfQuestion.choice1)
                    Text(selfQuestion.choice2)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("追加"){

                    }
                }
            }
        }
    }
}

#Preview {
    SelfQuestionList()
        .environmentObject(RealmViewModel())
}
