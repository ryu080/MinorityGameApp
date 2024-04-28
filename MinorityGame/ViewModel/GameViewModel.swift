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
    @Published var game:Game = Game(id: 0,users: [User(id: 1, name: "プレイヤー１", point: 0, totalPoints: 0, question: 0),User(id: 2, name: "プレイヤー2", point: 0, totalPoints: 0, question: 0),User(id: 3, name: "プレイヤー3", point: 0, totalPoints: 0, question: 0),User(id: 4, name: "プレイヤー4", point: 0, totalPoints: 0, question: 0),User(id: 5, name: "プレイヤー5", point: 0, totalPoints: 0, question: 0),User(id: 6, name: "プレイヤー6", point: 0, totalPoints: 0, question: 0),User(id: 7, name: "プレイヤー7", point: 0, totalPoints: 0, question: 0),User(id: 8, name: "プレイヤー8", point: 0, totalPoints: 0, question: 0),User(id: 9, name: "プレイヤー9", point: 0, totalPoints: 0, question: 0),User(id: 10, name: "プレイヤー10", point: 0, totalPoints: 0, question: 0),User(id: 11, name: "プレイヤー11", point: 0, totalPoints: 0, question: 0),User(id: 12, name: "プレイヤー12", point: 0, totalPoints: 0, question: 0),User(id: 13, name: "プレイヤー13", point: 0, totalPoints: 0, question: 0),User(id: 14, name: "プレイヤー14", point: 0, totalPoints: 0, question: 0),User(id: 15, name: "プレイヤー15", point: 0, totalPoints: 0, question: 0),User(id: 16, name: "プレイヤー16", point: 0, totalPoints: 0, question: 0),User(id: 17, name: "プレイヤー17", point: 0, totalPoints: 0, question: 0),User(id: 18, name: "プレイヤー18", point: 0, totalPoints: 0, question: 0),User(id: 19, name: "プレイヤー19", point: 0, totalPoints: 0, question: 0),User(id: 20, name: "プレイヤー20", point: 0, totalPoints: 0, question: 0)], nowGameCount: 1, maxGameCount: 2)
    @Published var questionText:String = ""
    @Published var isShowRule:Bool = false

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

    func createUser(name:String) {
        if game.users.count < 20 {
            let user = User(id: createId(), name: name,point: 0, totalPoints: 0,question: 0)
            game.users.append(user)
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
        }else {
            updateUserPoint(yes: 0, no: 1)
            return (choice2,Color.bittersweet)
        }
    }
    func userPoint(point:Int) -> String {
        switch point {
        case 0: return ""
        default: return "+1P"
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
            questionText = ""
            game.nowGameCount += 1
        }
    }

    func resetGame() {
        game.users = []
        questionText = ""
        game.nowGameCount = 1
    }
}
