//
//  CreateTripService.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 24/11/18.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation

enum TripParams : String {
    case NAME           = "name"
    case LAT            = "latitude"
    case LON            = "longitude"
    case DATE           = "date"
    case USER_CREATOR   = "creator"
    case DESC           = "description"
    case STATUS         = "status"
}

struct CreateTripService : BaseService {
    internal func createTrip(trip: Trip, completionHandler: @escaping (RequestResult<Any, String>) -> Void) {

        let endpoint = RequestData(path: FriendTripAPI.create, method: .post,
                                   params: [ TripParams.NAME.rawValue           : trip.name,
                                             TripParams.LAT.rawValue            : trip.latitude,
                                             TripParams.LON.rawValue            : trip.longitude,
                                             TripParams.DATE.rawValue           : trip.date,
                                             TripParams.USER_CREATOR.rawValue   : trip.creator,
                                             TripParams.DESC.rawValue           : trip.description,
                                             TripParams.STATUS.rawValue         : trip.status])
        self.request(endpoint: endpoint) { result in
            switch result {
            case .success(let json):
                completionHandler(RequestResult.success(json))
            case .failure(let error):
                completionHandler(RequestResult.failure(error))
            }
        }
    }
}

struct UserTripsService : BaseService {
    internal func getTrips(facebookID: String, completionHandler: @escaping (RequestResult<Any, String>) -> Void) {

        let endpoint = RequestData(path: FriendTripAPI.userTrips(facebookID: facebookID), method: .get)

        self.request(endpoint: endpoint) { ( result ) in
            switch result {
            case .success(let json):
                completionHandler(RequestResult.success(json))
            case .failure(let error):
                completionHandler(RequestResult.failure(error))
            }
        }
    }
}
