//
//  GameViewModel.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import Foundation

class GameViewModel:ObservableObject{
    @Published var game:Game = Game(id: 0, users: [], game: 0, result: false)
    @Published var users:[User] = [User(id: 0, name: "サンプル太", point: 0, question: 0),User(id: 1, name: "一郎", point: 0, question: 0),User(id: 2, name: "二郎", point: 0, question: 0),User(id: 3, name: "三郎", point: 0, question: 0),User(id: 4, name: "四郎", point: 0, question: 0),User(id: 5, name: "五郎", point: 0, question: 0),User(id: 6, name: "六郎", point: 0, question: 0),User(id: 7, name: "七郎", point: 0, question: 0),User(id: 8, name: "八郎", point: 0, question: 0),User(id: 9, name: "九郎", point: 0, question: 0)]
    @Published var maxGameCount:Int = 2
    @Published var nowGameCount:Int = 0
    @Published var questionText:String = "今日は日曜日ですか？"

    @Published var userCount:Int = 0
    @Published var mainOrGameView:Bool = false
    @Published var setView:Bool = false
    @Published var pageViewCount:Int = 0
    var yesUsers:[User] = []
    var noUsers:[User] = []

    func addGameCount(){
        if 10 > maxGameCount {
            maxGameCount += 1
        }
    }

    func subGameCount(){
        if 1 < maxGameCount {
            maxGameCount -= 1
        }
    }
    func count()->Int{
        if users.isEmpty{
            return 1
        }else{
            return users.last!.id+1
        }
    }

    func addUser(name:String) {
        if users.count < 20{
            let user = User(id: count(), name: name, point: 0,question: 0)
            users.append(user)
        }
    }

    func questionUser(id:Int,question:Int){
        for i in users.indices {
            if(users[i].id == id){
                users[i].question = question
            }
        }
    }

    func deleteUser(id:Int){
        users = users.filter({$0.id != (id)})
    }

    func voteCompleta(){
        if users.allSatisfy({$0.question != 0}){
            pageViewCount = 3
        }
    }

    func chooseQuestioner()->User{
        let i = Int.random(in: 0..<users.count)
        return users[i]
    }

    func yesUserCount() -> Int{
        yesUsers = users.filter({$0.question == 1})
        return yesUsers.count
    }
    func noUserCount() -> Int{
        noUsers = users.filter({$0.question == 2})
        return noUsers.count
    }

    func userPoint(yes:Int,no:Int) {
        for i in users.indices {
                if(users[i].question == 1){
                    users[i].point += yes
                }else if (users[i].question == 2){
                    users[i].point += no
                }
        }
    }

    func resultVote() -> String{
        let yes = yesUserCount()
        let no = noUserCount()
        if yes<no {
            userPoint(yes: 1, no: -1)
            return "少数派はYES"
        }else if yes>no {
            userPoint(yes: -1, no: 1)
            return "少数派はNO"
        }else {
            userPoint(yes: -1, no: -1)
            return "ドロー"
        }
    }

    func continueGame(){
        for i in users.indices {
            users[i].question = 0
        }
        questionText = ""
    }

    func resetGame(){
        users = []
        questionText = ""
    }
}
