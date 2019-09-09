//
//  FirebaseDatabase.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 17/07/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation

protocol TripDatabaseProtocol {
    func createTrip(userID: String, with trip: Trip, completion: @escaping (RequestResult<Bool, String>) -> Void)
    func getTrips(completion: @escaping ([Trip]) -> Void)
    func getTrips(for key: String, completion: @escaping ([Trip]) -> Void)
}

class TripDatabase {
    
    
    // MARK - Private variables
    
    private var database: FirebaseDatabaseServiceProtocol
    
    
    // MARK - Shared instance
    
    init(database: FirebaseDatabaseServiceProtocol = FirebaseDatabaseService(databaseName: "TripsDatabase")) {
        self.database = database
    }
}

extension TripDatabase: TripDatabaseProtocol {
    
    
    // MARK - Protocol Implementation
    
    func createTrip(userID: String, with trip: Trip, completion: @escaping (RequestResult<Bool, String>) -> Void) {

        guard let value: [String: Any] = trip.dictionary else {
            completion(RequestResult.failure("Error to get trip dictionary"))
            return
        }

        database.createItemchildByAutoID(value, for: userID) { (error) in
            if let error = error {
                completion(RequestResult.failure(error.localizedDescription))
            } else {
                completion(RequestResult.success(true))
            }
        }
    }
    
    func getTrips(completion: @escaping ([Trip]) -> Void) {

        
    }
    
    func getTrips(for key: String, completion: @escaping ([Trip]) -> Void) {
        database.getItems(for: key) { (items) in
            let trips: [Trip] = items.compactMap({
                Trip.from(id: $0.key, value: $0.value) })
            completion(trips)
        }
    }
}
