//
//  RequestData.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 23/11/18.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation
import Alamofire

struct RequestData {

    let path:      URL
    let method:    HTTPMethod
    let params:    [String: Any]?
    let headers:   [String: String]?

    init(path: FriendTripAPI,
         method: HTTPMethod,
         params: [String: Any]? = nil,
         headers: [String: String]? = nil) {
        self.path    = URL(string: path.baseURL.absoluteString + path.path)!
        self.method  = method
        self.params  = params 
        self.headers = headers
    }
}

