//
//  User.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 02/12/18.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String?
    let last_name: String?
    let picture: Picture?
    
    static func from(dictionary: [String: Any]) -> User? {
        
        guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) else {
            print("error to json serializable data.")
            return nil
        }
        guard let user = try? JSONDecoder().decode(User.self, from: data) else {
            print("error to decode serializable.")
            return nil
        }
    
        return user
    }
}

struct Picture: Codable {
    let data: FaceImage?
}

struct FaceImage: Codable {
    let height: Int?
    let width: Int
    let is_silhouette: Bool?
    let url: String?
}
