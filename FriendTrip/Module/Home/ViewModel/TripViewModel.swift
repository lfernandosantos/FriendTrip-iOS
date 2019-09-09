//
//  TripViewModel.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 02/09/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation

protocol TripViewModelProtocol {
    func create(trip: Trip, completion: @escaping (Bool)-> Void)
    func fetchTrips(completion: @escaping ([Trip]) -> Void)
}

final class TripViewModel: TripViewModelProtocol {
    
    let tripService: TripDatabaseProtocol = TripDatabase()
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func create(trip: Trip, completion: @escaping (Bool)-> Void) {
        //TODO: dispatchqueue
        tripService.createTrip(userID: user.id, with: trip) { (result) in
            switch result {
            case .success(_ ):
                print("OK")
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func fetchTrips(completion: @escaping ([Trip]) -> Void) {
        //TODO: dispatchqueue
        tripService.getTrips(for: user.id, completion: completion)
    }
}
