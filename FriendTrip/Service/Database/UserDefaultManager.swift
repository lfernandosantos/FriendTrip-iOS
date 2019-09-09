//
//  UserDefaultManager.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 03/12/18.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation

class UserDefaultManager {

    private let defaultManager = UserDefaults.standard
    
    init(){ }

    func loadFromUserDefault(key: String) -> Any? {
        return defaultManager.object(forKey: key)
    }

    func deleteToUserDefault(key: String) {
        self.defaultManager.removeObject(forKey: key)
    }

    func saveUserDefault(_ obj: Any, for key: String) {
        self.defaultManager.set(obj, forKey: key)
    }
}
