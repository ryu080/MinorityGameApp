//
//  DataViewModel.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/05.
//

import SwiftUI
import RealmSwift

final class RealmViewModel: ObservableObject {
    private var realm:Realm

    init() {
        //realmのマイグレーション
        let config = Realm.Configuration(
            schemaVersion: 3,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 3) {
                    }
            })

        Realm.Configuration.defaultConfiguration = config
        realm = try! Realm()
    }

    func createGame(game:Game){
        do{
            try realm.write {
                let realmGame = RealmGame()
                realmGame.id = game.id
                realmGame.nowGameCount = game.nowGameCount
                realmGame.maxGameCount = game.maxGameCount

                for user in game.users {
                    let realmUser = RealmUser()
                    realmUser.id = user.id
                    realmUser.name = user.name
                    realmUser.point = user.point
                    realmUser.totalPoints = user.totalPoints
                    realmUser.question = user.question
                    realmGame.users.append(realmUser)
                }
                realm.add(realmGame)
            }
        } catch {
            print("Error saving questions to Realm: \(error)")
        }
    }

    func readGame(id:Int) -> Game? {
        if let gameObject = realm.object(ofType:RealmGame.self, forPrimaryKey: id) {
            var users: [User] = []
            for userObject in gameObject.users {
                let user = User(id: userObject.id, name: userObject.name, point: userObject.point, totalPoints: userObject.totalPoints, question: userObject.question)
                users.append(user)
            }
            return Game(id: gameObject.id, users: users, nowGameCount: gameObject.nowGameCount, maxGameCount: gameObject.maxGameCount)
        }
        return nil
    }

    func updateGame(id:Int, updatedGame: Game) {
        do{
            if let gameObject = realm.object(ofType:RealmGame.self, forPrimaryKey: id) {
                try realm.write {
                    gameObject.nowGameCount = updatedGame.nowGameCount
                    gameObject.maxGameCount = updatedGame.maxGameCount
                    gameObject.users.removeAll()

                    for user in updatedGame.users {
                        let userObject = RealmUser()
                        userObject.id = user.id
                        userObject.name = user.name
                        userObject.point = user.point
                        userObject.totalPoints = user.totalPoints
                        userObject.question = user.question
                        gameObject.users.append(userObject)
                    }
                }
            }
        } catch {
            print("Error saving questions to Realm: \(error)")
        }
    }

    func deleteGame(id:Int) {
        do {
            if let gameObject = realm.object(ofType:RealmGame.self, forPrimaryKey: id) {
                try realm.write {
                    realm.delete(gameObject)
                }
            }
        } catch {
            print("Error saving questions to Realm: \(error)")
        }
    }

    func getFirestoreQuestions(questions: [FirestoreQuestion]) {
        do {
            try realm.write {
                // Firestoreから取得した全てのQuestionをRealmQuestionに変換して保存
                for firestoreQuestion in questions {
                    if let sameQuestion = realm.object(ofType: RealmQuestion.self, forPrimaryKey: firestoreQuestion.id) {
                        // 既存の質問がある場合は更新
                        sameQuestion.genre = firestoreQuestion.genre
                        sameQuestion.text = firestoreQuestion.text
                        sameQuestion.choice1 = firestoreQuestion.choice1
                        sameQuestion.choice2 = firestoreQuestion.choice2
                    } else {
                        // 既存の質問がない場合は新規追加
                        let realmQuestion = RealmQuestion()
                        realmQuestion.id = firestoreQuestion.id!
                        realmQuestion.genre = firestoreQuestion.genre
                        realmQuestion.text = firestoreQuestion.text
                        realmQuestion.choice1 = firestoreQuestion.choice1
                        realmQuestion.choice2 = firestoreQuestion.choice2
                        realm.add(realmQuestion)
                    }
                }
            }
            print(realm.objects(RealmQuestion.self))
        } catch {
            print("Error saving questions to Realm: \(error)")
        }
    }
    func setRealmQuestions() -> [RealmQuestion] {
        let RealmQuestions = realm.objects(RealmQuestion.self)
        var questions:[RealmQuestion] = []
        for question in RealmQuestions {
            questions.append(question)
        }
        return questions
    }

    func getRandomQuestion() async -> RealmQuestion? {
        let randomQuestion = realm.objects(RealmQuestion.self).randomElement()
        return randomQuestion
    }

    func getAllSelfQuestions() -> [RealmQuestion] {
        let realmQuestions = realm.objects(RealmQuestion.self)
        return realmQuestions.map { realmQuestion in
            return  realmQuestion
        }
    }

}
