//
//  DataViewModel.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/05.
//

import SwiftUI
import RealmSwift

class RealmViewModel: ObservableObject {

    //Realm C
        func createGame(game:Game){
            let realm = try! Realm()
            try! realm.write {
                let gameObject = GameObject()
                gameObject.id = game.id
                gameObject.nowGameCount = game.nowGameCount
                gameObject.maxGameCount = gameObject.maxGameCount

                for user in game.users {
                    let userObject = UserObject()
                    userObject.id = user.id
                    userObject.name = user.name
                    userObject.point = user.point
                    userObject.question = user.question
                    gameObject.users.append(userObject)
                }
                realm.add(gameObject)
            }
        }
        //Realm R
        func readGame(id:Int) -> Game? {
                let realm = try! Realm()
            if let gameObject = realm.object(ofType:GameObject.self, forPrimaryKey: id) {
                    var users: [User] = []
                    for userObject in gameObject.users {
                        let user = User(id: userObject.id, name: userObject.name, point: userObject.point, question: userObject.question)
                        users.append(user)
                    }
                    return Game(id: gameObject.id, users: users, nowGameCount: gameObject.nowGameCount, maxGameCount: gameObject.maxGameCount)
                }
                return nil
            }
        //Realm U
        func updateGame(id:Int, updatedGame: Game) {
                let realm = try! Realm()
                if let gameObject = realm.object(ofType:GameObject.self, forPrimaryKey: id) {
                    try! realm.write {
                        gameObject.nowGameCount = updatedGame.nowGameCount
                        gameObject.maxGameCount = updatedGame.maxGameCount
                        gameObject.users.removeAll()

                        for user in updatedGame.users {
                            let userObject = UserObject()
                            userObject.id = user.id
                            userObject.name = user.name
                            userObject.point = user.point
                            userObject.question = user.question
                            gameObject.users.append(userObject)
                        }
                    }
                }
            }
        //Realm D
        func deleteGame(id:Int) {
                let realm = try! Realm()
                if let gameObject = realm.object(ofType:GameObject.self, forPrimaryKey: id) {
                    try! realm.write {
                        realm.delete(gameObject)
                    }
                }
            }

}
