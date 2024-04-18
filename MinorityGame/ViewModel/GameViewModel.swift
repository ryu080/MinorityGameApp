//
//  GameViewModel.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import Foundation

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

    func resultVote() -> String {
        let yes = yesUser().count
        let no = noUser().count
        if yes<no && 0<yes{
            updateUserPoint(yes: 1, no: -1)
            return "少数派はYES"
        }else if no<yes && 0<no{
            updateUserPoint(yes: -1, no: 1)
            return "少数派はNO"
        }else {
            updateUserPoint(yes: 0, no: 0)
            return "ドロー"
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
