//
//  ViewController.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 23/11/18.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        RegisterUserService().registerUser(facebookID: "sionfios",
                                           name: "fernando") { result in
            print(result)
        }

        CreateTripService().createTrip(trip: Trip( id: nil, name: "Trip do ios 2", latitude: "rrrrf2", longitude: "fer3f", date: "f3f3", creator: "f3v3c3c3", description: "2fdsvmodfimv", status: "Created")) { (result) in

            print(result)
            
        }

    }

}

