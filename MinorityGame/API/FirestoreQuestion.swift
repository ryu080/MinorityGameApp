//
//  FireStore.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/20.
//

import FirebaseFirestoreSwift
import FirebaseFirestore

struct FirestoreQuestion: Codable {
    @DocumentID var id: String? // Firestoreに保存する際に自動生成されるID
    var genre:String
    var text: String
    var choice1: String
    var choice2: String
}


//import FirebaseFirestore
//
//class FirestoreRepository {
//    private let db = Firestore.firestore()
//
//    func getAllQuestions() async throws -> [FirestoreQuestion] {
//        let querySnapshot = try await db.collection("questions").getDocuments()
//        return try querySnapshot.documents.compactMap {
//            try $0.data(as: FirestoreQuestion.self)
//        }
//    }
//}
//
//import RealmSwift
//
//class RealmRepository {
//    func saveQuestions( questions: [FirestoreQuestion]) {
//        do {
//            let realm = try  Realm()
//            try realm.write {
//                // Firestoreから取得した全てのQuestionをRealmQuestionに変換して保存
//                for firestoreQuestion in questions {
//                    let realmQuestion = RealmQuestion()
//                    realmQuestion.id = ObjectId.generate()
//                    realmQuestion.text = firestoreQuestion.text
//                    realmQuestion.choice1 = firestoreQuestion.choice1
//                    realmQuestion.choice2 = firestoreQuestion.choice2
//
//                    realm.add(realmQuestion)
//                }
//            }
//        } catch {
//            print("Error saving questions to Realm: \(error)")
//        }
//    }
//
//    func getRandomQuestion() async -> RealmQuestion? {
//        let realm = try! await Realm()
//        return realm.objects(RealmQuestion.self).randomElement()
//    }
//}
//
//import SwiftUI
//import RealmSwift

//class QuestionViewModel: ObservableObject {
//    private let firestoreRepository = FirestoreRepository()
//    private let realmRepository = RealmRepository()
//
//    @Published var randomQuestion: RealmQuestion?
//
//    func fetchAllQuestionsAndSaveToRealm() async {
//        do {
//            let firestoreQuestions = try await firestoreRepository.getAllQuestions()
//            realmRepository.saveQuestions(questions: firestoreQuestions)
//        } catch {
//            print("Error fetching and saving questions: \(error)")
//        }
//    }
//
//    func getRandomQuestion() async {
//        self.randomQuestion = await realmRepository.getRandomQuestion()
//    }
//}
//
//import SwiftUI
//
//struct SwiftUIView: View {
//    @StateObject private var questionViewModel = QuestionViewModel()
//
//    var body: some View {
//        VStack {
//            Button("Fetch Questions from Firestore") {
//                    DispatchQueue.main.async {
//                        Task{
//                            await questionViewModel.fetchAllQuestionsAndSaveToRealm()
//
//                        }
//                    }
//            }
//            .padding()
//
//            Button("Get Random Question") {
//                Task {
//                    await questionViewModel.getRandomQuestion()
//                }
//            }
//            .padding()
//
//            if let question = questionViewModel.randomQuestion {
//                Text("Random Question:")
//                Text("ID: \(question.id)")
//                Text("Text: \(question.text)")
//                Text("Choice 1: \(question.choice1)")
//                Text("Choice 2: \(question.choice2)")
//            }
//        }
//        .onAppear {
//            // アプリ起動時にFirestoreから質問を取得してRealmに保存
//            Task {
//                await questionViewModel.fetchAllQuestionsAndSaveToRealm()
//            }
//        }
//    }
//}
