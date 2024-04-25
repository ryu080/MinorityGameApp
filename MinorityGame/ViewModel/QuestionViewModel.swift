//
//  questionViewModel.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/21.
//

import SwiftUI
import RealmSwift

class QuestionViewModel:ObservableObject {
    private let firestoreDataBase = FirestoreClient()
//    private let realmRepository = RealmRepository()

    @Published var questions:[RealmQuestion] = []
    @Published var question:RealmQuestion?
    @Published var isShowProgress:Bool?

    func setQuestionsRealm(realm:RealmViewModel) async {
        do {
                let firestoreQuestions = try await firestoreDataBase.getAllQuestions()
            DispatchQueue.main.async{
                realm.getFirestoreQuestions(questions: firestoreQuestions)
                self.questions = realm.setRealmQuestions()
                self.isShowProgress = false
            }
        } catch {
            //エラーの場合再起動orAlertとで落とす
            print("setQuestionsRealm: \(error)")
            DispatchQueue.main.async{
                self.isShowProgress = true
            }
        }
    }
    func getRandomQuestionRealm()  {
        self.question = questions.randomElement()
    }
//    func getRandomQuestionRealm(realm:RealmViewModel) async {
//        self.question = await realm.getRandomQuestion()
//    }
    func selfQuestions(realm:RealmViewModel)->[RealmQuestion]{
        return realm.getAllSelfQuestions()
    }
    func setSelfQuestionRealm(realm:RealmViewModel) {

    }
    func getRandomSelfQuestionRealm(realm:RealmViewModel) {

    }
}
