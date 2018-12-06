//
//  User.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 02/12/18.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation

class User: NSObject {
    let facebookID: String
    let name: String
    let imagePath: String?

    init(facebookID: String, name: String, imagePath: String?) {
        self.facebookID = facebookID
        self.name       = name
        self.imagePath  = imagePath
    }
}
