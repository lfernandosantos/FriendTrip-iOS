//
//  FriendTripAPI.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 23/11/18.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation

protocol APIPath {
    var baseURL:  URL    {get}
    var path:     String {get}
}

enum FriendTripAPI {

    //POST
    case register
    case create

    //GET
    case userTrips(facebookID: String)
    case locationTrips(latitude: String, longitude: String)


}

extension FriendTripAPI: APIPath {
    public var baseURL: URL {
        return URL(string: "http://localhost:8080/api/v1/")!
    }

    public var path: String {
        switch self {
        case .register:
            return "register"
        case .create:
            return "create"
        case .userTrips(let facebookID):
            return "trips/my/\(facebookID)"
        case .locationTrips(let latitude, let longitude):
            return "trips/location"
        }
    }
}
