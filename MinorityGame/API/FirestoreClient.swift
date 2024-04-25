//
//  StoreViewModel.swift
//  MinorityGame
//
//  Created by 辻野竜志 on 2024/04/21.
//

import Foundation
import FirebaseFirestore

class FirestoreClient{
    private let db = Firestore.firestore()

    func getAllQuestions() async throws -> [FirestoreQuestion] {
        let querySnapshot = try await db.collection("questions").getDocuments()
        return try querySnapshot.documents.compactMap {
            try $0.data(as: FirestoreQuestion.self)
        }
    }
}
