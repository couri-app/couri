//
//  FIRFirestoreService.swift
//  Couri
//
//  Created by David Chen on 7/7/19.
//  Copyright © 2019 Couri. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class FIRFirestoreService {
    private init() {}
    static let shared = FIRFirestoreService()
    
    func configure() {
        FirebaseApp.configure()
    }
    
    private func reference(to collectionReference: FIRCollectionReference) -> CollectionReference {
        return Firestore.firestore().collection(collectionReference.rawValue)
    }
    
    func create<T: Codable>(for encodableObject: T, in collectionReference: FIRCollectionReference) {
        do {
            let json = try encodableObject.toJson()
            reference(to: .restaurants).addDocument(data: json)
        } catch { print(error) }
        
    }
    
    func read<T: Codable>(for encodableObject: T, in collectionReference: FIRCollectionReference) {
        
        do {
            let json = try encodableObject.toJson()
        } catch { print(error) }
        
        reference(to: .restaurants).addSnapshotListener { (snapshot, _) in
            guard let snapshot = snapshot else { return }
            for doc in snapshot.documents {
                print(doc.data())
            }
        }
    }
    
    func update() {
        reference(to: .restaurants).document("0").setData(["couriers" : +1])
    }
}

enum FIRCollectionReference: String {
    case restaurants
    case couriers
    case menu
}

enum CouriError: Error {
    case encodingError
}

extension Encodable {
    func toJson() throws -> [String: Any] {
        let objectData = try JSONEncoder().encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: objectData, options: [])
        guard var json = jsonObject as? [String : Any] else { throw CouriError.encodingError}
        
        return json
    }
}
