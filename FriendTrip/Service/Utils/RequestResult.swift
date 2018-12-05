//
//  RequestResult.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 23/11/18.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation
enum RequestResult<T, String> {
    case success(T)
    case failure(String)
}
