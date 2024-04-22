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

    func setQuestions(questions: [FirestoreQuestion]) {
        do {
            try realm.write {
                // Firestoreから取得した全てのQuestionをRealmQuestionに変換して保存
                for firestoreQuestion in questions {
                    let realmQuestion = RealmQuestion()
                    realmQuestion.id = ObjectId.generate()
                    realmQuestion.text = firestoreQuestion.text
                    realmQuestion.choice1 = firestoreQuestion.choice1
                    realmQuestion.choice2 = firestoreQuestion.choice2

                    realm.add(realmQuestion)
                }
            }
        } catch {
            print("Error saving questions to Realm: \(error)")
        }
    }

    func getRandomQuestion() async -> RealmQuestion? {
        return realm.objects(RealmQuestion.self).randomElement()
    }

    func getAllSelfQuestions() -> [RealmQuestion] {
        let realmQuestions = realm.objects(RealmQuestion.self)
        return realmQuestions.map { realmQuestion in
            return  realmQuestion
        }
    }

}
