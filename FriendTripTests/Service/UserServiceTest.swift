//
//  UserServiceTest.swift
//  FriendTripTests
//
//  Created by Luiz Fernando dos Santos on 04/08/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import XCTest

@testable import FriendTrip
class UserServiceTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSaveUser(){
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

let tripsJSONMock: [String: Any] = [
    "fernandoID" : [
        "23kofmoindss" : [
            "id" : "23kofmoindss",
            "name" : "Bico do papagaio",
            "date" : "20-09-2020"
        ],
        "ewlkmkfmew" : [
            "id" : "ewlkmkfmew",
            "name" : "Costão",
            "date" : "20-05-2020"
        ]
    ]
]

let userTripsJSONMOCK: [String: Any] = [
    "ewlkmkfmew" : [
        "id" : "ewlkmkfmew",
        "name" : "Costão",
        "date" : "20-05-2020"
    ]]
class FirebaseDataBaseMock: FirebaseDatabaseServiceProtocol {
    func createItem(_ item: [String : Any?], for key: String, completion: @escaping (Error?) -> Void) {
        completion(nil)
    }
    
    func createItemchildByAutoID(_ item: [String : Any?], for key: String, completion: @escaping (Error?) -> Void) {
        completion(nil)
    }
    
    func getItems(completion: @escaping ([String : Any]) -> Void) {
        completion(tripsJSONMock)
    }
    
    func getItems(for key: String, completion: @escaping ([String : Any]) -> Void) {
        completion(userTripsJSONMOCK)
    }
}


class FirebaseDataBaseMockError: FirebaseDatabaseServiceProtocol {
    func createItem(_ item: [String : Any?], for key: String, completion: @escaping (Error?) -> Void) {
        completion(nil)
    }
    
    func createItemchildByAutoID(_ item: [String : Any?], for key: String, completion: @escaping (Error?) -> Void) {
        completion(nil)
    }
    
    func getItems(completion: @escaping ([String : Any]) -> Void) {
        completion([:])
    }
    
    func getItems(for key: String, completion: @escaping ([String : Any]) -> Void) {
        completion([:])
    }
}

class FirebaseTripDatabaseMock: TripDatabaseProtocol {
    func createTrip(userID: String, with trip: Trip, completion: @escaping (RequestResult<Bool, String>) -> Void) {
        completion(RequestResult.success(true))
    }
    
    func getTrips(for key: String, completion: @escaping ([Trip]) -> Void) {
        var trips: [Trip] =
            [
                Trip(name: "Teste Trip", latitude: "-122343434", longitude: "-23424234", date: "20/05/2018", creator: "Fernando", description: "trip testes description", status: "created"),
                Trip(name: "Teste Trip 2", latitude: "-122343434", longitude: "-23424234", date: "20/05/2018", creator: "Fernando", description: "trip testes description", status: "created")
        ]
        completion(trips)
    }
    
    
    func getTrips(completion: @escaping ([Trip]) -> Void) {
            
        let trips: [Trip] =
            [
                Trip(name: "Teste Trip", latitude: "-122343434", longitude: "-23424234", date: "20/05/2018", creator: "Fernando", description: "trip testes description", status: "created"),
                Trip(name: "Teste Trip 2", latitude: "-122343434", longitude: "-23424234", date: "20/05/2018", creator: "Fernando", description: "trip testes description", status: "created")
        ]
        completion(trips)
    }
}

class FirebaseTripDatabaseMockError: TripDatabaseProtocol {
    func createTrip(userID: String, with trip: Trip, completion: @escaping (RequestResult<Bool, String>) -> Void) {
        completion(RequestResult.failure("Error"))
    }
    
    func getTrips(for key: String, completion: @escaping ([Trip]) -> Void) {
        let trips: [Trip] = []
        completion(trips)
    }

    
    func getTrips(completion: @escaping ([Trip]) -> Void) {
        completion([])
    }
}
