//
//  UserDefaultManager.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 03/12/18.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation

class UserDefaultManager {
    private init(){ }

    internal let defaultManager = UserDefaults.standard
    static let shared = UserDefaultManager()

    internal func loadUserDefault(for key: String, completion: @escaping (RequestResult<Any?, String>) -> Void) {
        if let object = defaultManager.object(forKey: key) as? Data {
            let obj = NSKeyedUnarchiver.unarchiveObject(with: object)
            completion(NetloloSDKResult.success(obj))
        } else {
            completion(NetloloSDKResult.failure("error to load user defaults."))
            print("error to load user defaults.")
        }
    }

    internal func loadFromUserDefault(key: String) -> Any? {
        if let object = defaultManager.object(forKey: key) as? Data {
            let obj = NSKeyedUnarchiver.unarchiveObject(with: object)
            return obj
        }
        return nil
    }

    internal func saveUserDefault(_ obj: Any?, for key: String) {
        if obj != nil {
            let dataObj = NSKeyedArchiver.archivedData(withRootObject: obj!)
            self.defaultManager.set(dataObj, forKey: key)
        } else {
            self.defaultManager.set(nil, forKey: key)
        }
        //  Save to disk
        let didSave = self.defaultManager.synchronize()
        if !didSave {
            print("couldn't save")
        }
    }

}
