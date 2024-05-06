//
//  User.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/03/28.
//

import Foundation
import SwiftUI

struct User: Identifiable {
    let id:Int
    let imageData:Data?
    let name:String
    var point:Int
    var totalPoints:Int
    var question:Int
}
