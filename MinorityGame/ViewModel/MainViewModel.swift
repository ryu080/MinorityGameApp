//
//  MainViewModel.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import Foundation

class MainViewModel: ObservableObject {

    @Published var game:Game = Game(id: 0, users: [User(id: 0, name: "サンプルた", point: 0, question: 0)], gameCount: 2, inGame: true)

    func newGame(){
        game.inGame = false
    }
}
