//
//  LoginViewModel.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 02/12/18.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation
import UIKit

protocol LoginViewModel {
    func login( completionHandler: @escaping ((RequestResult<Bool, String>) -> Void))
}


extension LoginViewModel {

    internal func login( facebookID: String, completion: @escaping ((RequestResult<Bool, String>) -> Void )) {

        //todo: get from database
        //todo: update database
        //todo: dinamic update
    }
}

class LoginVM {

    var nameUser    : String?
    var emailUser   : String?
    var imageUser   : UIImage?
    var user        : User?

    func makeLogin(facebookID: String, completionHandler: @escaping () -> Void) {

        RegisterUserService().registerUser(facebookID: facebookID,
                                           name: "fernando") { result in
            switch result {
            case .success(let json):
                completionHandler()
            case .failure(let error):
                completionHandler()
            }
        }
    }

    func saveUser(user: User) {
        UserDefaultManager.shared.saveUserDefault(user, for: "user")
    }

//    func getUser() -> User? {
//        return UserDefaultManager.shared.loadFromUserDefault(key: "user")
//    }

    func logoutUser() {
        UserDefaultManager.shared.deleteToUserDefault(key: "user")
    }

}
