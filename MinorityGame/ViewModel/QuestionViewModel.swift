//
//  questionViewModel.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/21.
//

import Foundation
import RealmSwift

class QuestionViewModel:ObservableObject {
    private let firestoreDataBase = FirestoreDataBase()
//    private let realmRepository = RealmRepository()

    @Published var question: RealmQuestion?

    func setQuestionsRealm(realm:RealmViewModel) async {
        do {
            let firestoreQuestions = try await firestoreDataBase.getAllQuestions()
            realm.setQuestions(questions: firestoreQuestions)
        } catch {
            print("Error fetching and saving questions: \(error)")
        }
    }
    func getRandomQuestionRealm(realm:RealmViewModel) async {
        self.question = await realm.getRandomQuestion()
    }
    func selfQuestions(realm:RealmViewModel)->[RealmQuestion]{
        return realm.getAllSelfQuestions()
    }
    func setSelfQuestionRealm(realm:RealmViewModel) {

    }
    func getRandomSelfQuestionRealm(realm:RealmViewModel) {

    }
}
