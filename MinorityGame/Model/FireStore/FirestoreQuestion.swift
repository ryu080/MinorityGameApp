//
//  FireStore.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/20.
//

import FirebaseFirestoreSwift
import FirebaseFirestore

struct FirestoreQuestion: Codable {
    @DocumentID var id: String?
    var genre:String
    var text: String
    var choice1: String
    var choice2: String
}
