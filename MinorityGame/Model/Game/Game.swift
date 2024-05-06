//
//  Game.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import Foundation

struct Game: Identifiable{
    var id:Int
    var users:[User]
    var questions:[RealmQuestion]
    var nowGameCount:Int
    var maxGameCount:Int
}
