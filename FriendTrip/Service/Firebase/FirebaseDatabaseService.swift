//
//  FirebaseDatabaseService.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 15/08/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import FirebaseDatabase

protocol FirebaseDatabaseServiceProtocol {
    func createItem(_ item: [String : Any?], for key: String, completion: @escaping (Error?) -> Void)
    func createItemchildByAutoID(_ item: [String : Any?], for key: String, completion: @escaping (Error?) -> Void)
    func getItems(completion: @escaping ([String: Any]) -> Void)
    func getItems(for key: String, completion: @escaping ([String: Any]) -> Void)
}

final class FirebaseDatabaseService: FirebaseDatabaseServiceProtocol {
    
    private let firebase: DatabaseReference
    private let databaseName: String
    
    init(databaseName: String,
         firebase: DatabaseReference = Database.database().reference()) {
        self.databaseName = databaseName
        self.firebase = firebase
    }
    
    private func database() -> DatabaseReference {
        return firebase.child(databaseName)
    }

    func createItem(_ item: [String : Any?], for key: String, completion: @escaping (Error?) -> Void) {
        self.database().child(key).setValue(item) { (error, reference) in
            guard error == nil else {
                completion(error)
                return
            }
            
            completion(nil)
        }
    }
    
    func createItemchildByAutoID(_ item: [String : Any?], for key: String, completion: @escaping (Error?) -> Void) {
        self.database().child(key).childByAutoId().setValue(item) { (error, reference) in
            guard error == nil else {
                completion(error)
                return
            }
            
            completion(nil)
        }
    }
    
    func getItems(for key: String, completion: @escaping ([String: Any]) -> Void)  {
        self.database().child(key).observe(.value) { (data) in
            
            guard let items: [String: Any] = data.value as? [String: Any] else {
                completion([:])
                
                return
            }
            completion(items)
        }
    }
    
    func getItems(completion: @escaping ([String: Any]) -> Void) {
        self.database().observeSingleEvent(of: .value) { (data) in
            
            guard let items = data.value as? [String: Any] else {
                completion([:])
                return
            }
            
            completion(items)
        }
    }
    
    
    
    
}
