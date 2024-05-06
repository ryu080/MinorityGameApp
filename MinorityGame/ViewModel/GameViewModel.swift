//
//  GameViewModel.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import Foundation
import SwiftUI

@MainActor
final class GameViewModel:ObservableObject {
    @Published var game:Game = Game(id: 0,users: [], questions: [], nowGameCount: 1, maxGameCount: 2)
    @Published var isShowRule:Bool = false

    func setPreviousUsers(realm:RealmViewModel){
        if let previousUsers = realm.readGame(primaryKey: 1){
            game = previousUsers
        }
    }

    func gameCountUp() {
        if 10 > game.maxGameCount {
            game.maxGameCount += 1
        }
    }

    func gameCountDown() {
        if 1 < game.maxGameCount {
            game.maxGameCount -= 1
        }
    }

    private func createId() -> Int {
        if game.users.isEmpty{
            return 1
        } else {
            return game.users.last!.id+1
        }
    }

    func createUser(name:String,imageData:Data?) {
        let maxUserCount = 12
        if game.users.count < maxUserCount {
            let user = User(id: createId(), imageData: imageData, name: name,point: 0, totalPoints: 0,question: 0)
            game.users.append(user)
        }
    }

    func limitUserCount(genre:String?)->(Bool,Bool){
        if game.users.count > 3 || game.users.count < 12 {
            if genre != nil {
                return (true,true)
            }else{
                return (true,false)
            }
        }else{
            return (false,true)
        }
    }

    func updateUserQuestion(id:Int, question:Int) {
        for i in game.users.indices {
            if(game.users[i].id == id) {
                game.users[i].question = question
            }
        }
    }

    func updateUserPoint(yes:Int,no:Int) {
        for i in game.users.indices {
            if(game.users[i].question == 1) {
                game.users[i].totalPoints += yes
                game.users[i].point = yes
            }else if (game.users[i].question == 2) {
                game.users[i].totalPoints += no
                game.users[i].point = no
            }
        }
    }

    func deleteUser(id:Int) {
        game.users = game.users.filter({$0.id != (id)})
    }

    func chooseQuestioner() -> User {
        let i = Int.random(in: 0..<game.users.count)
        return game.users[i]
    }

    func voteComplete()->Bool {
        if game.users.allSatisfy({$0.question != 0}) {
            return true
        } else {
            return false
        }
    }

    func yesUser() -> [User] {
        let yesUsers:[User] = game.users.filter({$0.question == 1})
        return yesUsers
    }
    func noUser() -> [User] {
        let noUsers:[User] = game.users.filter({$0.question == 2})
        return noUsers
    }

    //ドローとポイントのマイナスをなくす
    func resultVote(choice1:String,choice2:String) -> (String,Color) {
        let yes = yesUser().count
        let no = noUser().count
        if yes<no {
            updateUserPoint(yes: 1, no: 0)
            return (choice1,Color.electricBlue)
        }else if no<yes {
            updateUserPoint(yes: 0, no: 1)
            return (choice2,Color.bittersweet)
        }else {
            updateUserPoint(yes: 0, no: 0)
            return ("ドロー",Color.green)
        }
    }
    func userPoint(users:[User]) -> Bool {
        if users.first?.point == 0 {
            return false
        }else{
            return true
        }
    }

    func winnerUser()->[User]{
        guard let maxPoint = game.users.max(by: { $0.totalPoints < $1.totalPoints })?.totalPoints else {
            return []
        }
        let winner = game.users.filter({$0.totalPoints == maxPoint})
        return winner
    }

    func continueGame() {
        if game.users.allSatisfy({$0.question != 0}){
            for i in game.users.indices {
                game.users[i].question = 0
            }
            game.nowGameCount += 1
        }
    }

    func resetGame() {
        game.users = []
        game.nowGameCount = 1
    }
}
