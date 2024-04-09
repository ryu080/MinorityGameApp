//
//  RealmModel.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/03.
//

import RealmSwift

class UserObject: Object {
    @Persisted var id: Int
    @Persisted var name:String
    @Persisted var point:Int
    @Persisted var question:Int
}

class GameObject: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id:Int
    @Persisted var users = List<UserObject>()
    @Persisted var nowGameCount:Int
    @Persisted var maxGameCount:Int
}
