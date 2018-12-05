//
//  Trip.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 24/11/18.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation

class Trip {
    let id: CLong?
    let name: String
    let latitude: String
    let longitude: String
    let date: String
    let creator: String
    let description: String
    let status: String

    init(id: CLong?, name: String, latitude: String,
         longitude: String, date: String,
         creator: String, description: String,
         status: String) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.date = date
        self.creator = creator
        self.description = description
        self.status = status
    }
}
