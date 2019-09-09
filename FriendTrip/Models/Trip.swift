//
//  Trip.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 24/11/18.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation

struct Trip:  Codable {
    var id: String?
    let name: String
    let latitude: String
    let longitude: String
    let date: String
    let creator: String
    let description: String
    let status: String

    init(name: String, latitude: String,
         longitude: String, date: String,
         creator: String, description: String,
         status: String) {
        self.id = ""
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.date = date
        self.creator = creator
        self.description = description
        self.status = status
    }
    
    static func from(id: String, value: Any) -> Trip? {
        
        if let data = value as? [String: String] {
            var tripJSON: [String: String?] = data
            tripJSON["id"] = id
            
            guard let data = try? JSONSerialization.data(withJSONObject: tripJSON, options: .prettyPrinted) else {
                print("error to json serializable data.")
                return nil
            }
            
            guard let trip = try? JSONDecoder().decode(Trip.self, from: data) else {
                print("error to decode serializable.")
                return nil
            }
            return trip
        }
        
        return nil
    }
}
