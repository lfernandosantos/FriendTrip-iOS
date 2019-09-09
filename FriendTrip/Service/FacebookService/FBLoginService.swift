//
//  FBLoginService.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 02/12/18.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation
import FBSDKLoginKit

enum FacebookLoginParams: String {
    case PROFILE        = "public_profile"
    case EMAIL          = "email"
    case USER_FRIENDS   = "user_friends"
    case USER_PHOTO     = "user_photos"
}

protocol LoginFBRequestProtocol {
    func getUserInfo(accessToken: AccessToken, completion: @escaping (_ :[String:Any]?, _ : Error?) -> Void)
}

class LoginFBRequest: LoginFBRequestProtocol {

    func getUserInfo(accessToken: AccessToken, completion: @escaping (_ :[String:Any]?, _ : Error?) -> Void) {
        let parameters = ["fields": "id, name, email, first_name, last_name, picture.type(large)"]
        GraphRequest(graphPath: "me", parameters: parameters, httpMethod: .post).start { (connection, value, error) in

            if let error = error {
                completion(nil, error)
            }
            
            let data = value as? [String: Any]
            
            completion(data, nil)
        }
    }
}



