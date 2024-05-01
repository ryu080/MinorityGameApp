//
//  GameViewModel.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import Foundation
import SwiftUI

//[User(id: 1, imageData: nil, name: "プレイヤー１", point: 0, totalPoints: 0, question: 0),User(id: 2, imageData: nil, name: "プレイヤー2", point: 0, totalPoints: 0, question: 0),User(id: 3, imageData: nil, name: "プレイヤー3", point: 0, totalPoints: 0, question: 0),User(id: 4, imageData: nil, name: "プレイヤー4", point: 0, totalPoints: 0, question: 0),User(id: 5, imageData: nil, name: "プレイヤー5", point: 0, totalPoints: 0, question: 0),User(id: 6, imageData: nil, name: "プレイヤー6", point: 0, totalPoints: 0, question: 0),User(id: 7, imageData: nil, name: "プレイヤー7", point: 0, totalPoints: 0, question: 0),User(id: 8, imageData: nil, name: "プレイヤー8", point: 0, totalPoints: 0, question: 0),User(id: 9, imageData: nil, name: "プレイヤー9", point: 0, totalPoints: 0, question: 0),User(id: 10, imageData: nil, name: "プレイヤー10", point: 0, totalPoints: 0, question: 0),User(id: 11, imageData: nil, name: "プレイヤー11", point: 0, totalPoints: 0, question: 0),User(id: 12, imageData: nil, name: "プレイヤー12", point: 0, totalPoints: 0, question: 0),User(id: 13, imageData: nil, name: "プレイヤー13", point: 0, totalPoints: 0, question: 0),User(id: 14, imageData: nil, name: "プレイヤー14", point: 0, totalPoints: 0, question: 0),User(id: 15, imageData: nil, name: "プレイヤー15", point: 0, totalPoints: 0, question: 0),User(id: 16, imageData: nil, name: "プレイヤー16", point: 0, totalPoints: 0, question: 0),User(id: 17, imageData: nil, name: "プレイヤー17", point: 0, totalPoints: 0, question: 0),User(id: 18, imageData: nil, name: "プレイヤー18", point: 0, totalPoints: 0, question: 0),User(id: 19, imageData: nil, name: "プレイヤー19", point: 0, totalPoints: 0, question: 0)]

@MainActor
final class GameViewModel:ObservableObject {
    @Published var game:Game = Game(id: 0,users: [], nowGameCount: 1, maxGameCount: 2)
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

    func createUser(name:String,imageData:Data?) {
        if game.users.count < 20 {
            let user = User(id: createId(), imageData: imageData, name: name,point: 0, totalPoints: 0,question: 0)
            game.users.append(user)
        }
    }

    func limitUserCount(root:RootViewModel, alert:AlertViewModel){
        if game.users.count < 3 || game.users.count > 20 {
            alert.playerCountAlert()
        }else{
            root.nextGameView(nextView: .discussionView)
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
