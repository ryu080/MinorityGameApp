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

    @Published var allQuestions:[RealmQuestion] = []
    @Published var useQuestions:[RealmQuestion] = []
    @Published var question:RealmQuestion?
    @Published var isShowProgress:Bool?
    @Published var isFirstLoadingQuestions:Bool = true

    let questions: [FirestoreQuestion] = []

    func addQuestions() {
        firestoreDataBase.addQuestion(questions: questions)
    }

    func setAllQuestionsRealm(realm:RealmViewModel) async {
        do {
                let firestoreQuestions = try await firestoreDataBase.getAllQuestions()
            DispatchQueue.main.async{
                realm.getFirestoreQuestions(questions: firestoreQuestions)
                self.allQuestions = realm.setRealmQuestions()
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
    func setUseQuestionsRealm(maxGameCount: Int,genre:String)->[RealmQuestion]{
        var questions = allQuestions.filter({$0.genre == genre})
        var genreQuestion:[RealmQuestion] = []
        for _ in 0 ..< maxGameCount {
            if let question = questions.randomElement() {
                questions = questions.filter({$0 != question})
                genreQuestion.append(question)
            }else {
                print("error")
            }
        }
        return genreQuestion
    }

    func getRandomQuestionRealm(nowGameCount: Int)  {
        question = useQuestions[(nowGameCount - 1)]
        print(String(describing: question))
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
