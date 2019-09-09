//
//  HomeView.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 15/07/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    @IBOutlet weak var createTripButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userDic = UserDefaultManager().loadFromUserDefault(key: "user") as? [String: Any] {
            guard let user = User.from(dictionary: userDic) else { return }
            let tripViewModel = TripViewModel(user: user)
            
            print(tripViewModel.user)
            
        }
        
    }
    
    @IBAction func createTrip(_ sender: Any) {
    }
}
