//
//  FirebaseUserService.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 04/08/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation

protocol FirebaseUserServiceProtocol {
    func saveUser(completion: @escaping (RequestResult<Bool, String?>) -> Void)
    func addTrip(trip: Trip)
    func getUserTrips(completion: @escaping ([Trip]) -> Void)
}

class FirebaseUserService {
    

    // MARK - Private variables
    
    private let database: FirebaseDatabaseServiceProtocol
    private let tripDatabase: TripDatabaseProtocol
    private let user: User
    
    
    init(database: FirebaseDatabaseServiceProtocol = FirebaseDatabaseService(databaseName: "User"),
         tripDatabase: TripDatabaseProtocol = TripDatabase(),
         user: User) {
        self.database = database
        self.tripDatabase = tripDatabase
        self.user = user
    }
    
}


// MARK - Protocol Implementation

extension FirebaseUserService: FirebaseUserServiceProtocol {

    
    func getUserTrips(completion: @escaping ([Trip]) -> Void) {
        tripDatabase.getTrips(for: user.id) { (trips) in
            completion(trips)
        }
    }
    
    func addTrip(trip: Trip) {
        tripDatabase.createTrip(userID: user.id, with: trip) { resul in
            switch resul {
            case .failure(let error):
                print(error)
            case .success(_ ):
                print("OK")
            }
        }
    }
    
    func saveUser(completion: @escaping (RequestResult<Bool, String?>) -> Void) {
        guard let userDictionary = user.dictionary else {
            return
        }
        
        database.createItem(userDictionary, for: user.id) { (error) in
            if let error = error {
                completion(RequestResult.failure(error.localizedDescription))
            } else {
                completion(RequestResult.success(true))
            }
        }
    }
}
