//
//  Game.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import Foundation

struct Game: Identifiable{
    var id: Int
    let users:[User]
    var game:Int
    var result:Bool
}
