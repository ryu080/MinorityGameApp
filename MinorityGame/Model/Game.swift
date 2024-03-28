//
//  Game.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import Foundation

struct Game: Identifiable, Equatable{
    //比較に必要　要勉強
    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.id == rhs.id
    }

    var id: Int
    let users:[User]
    var gameCount:Int
    var inGame:Bool
}
