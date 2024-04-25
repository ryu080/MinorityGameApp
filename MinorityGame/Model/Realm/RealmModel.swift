//
//  RealmModel.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/03.
//

import RealmSwift

class RealmUser: Object {
    @Persisted var id: Int
    @Persisted var name:String
    @Persisted var point:Int
    @Persisted var totalPoints:Int
    @Persisted var question:Int
}

class RealmGame: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id:Int
    @Persisted var users = List<RealmUser>()
    @Persisted var nowGameCount:Int
    @Persisted var maxGameCount:Int
}

class RealmQuestion: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id:String
    @Persisted var genre:String
    @Persisted var text: String
    @Persisted var choice1: String
    @Persisted var choice2: String
}

class RealmSelfQuestion:Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id:ObjectId
    @Persisted var genre:String
    @Persisted var text: String
    @Persisted var choice1: String
    @Persisted var choice2: String
}
