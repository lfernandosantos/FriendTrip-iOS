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


//import UIKit
//
//class LoginFBRequest: NSObject {
//
//    func getUserInfo(accessToken: FBSDKAccessToken, completion: @escaping (_ :[String:Any]?, _ : Error?) -> Void) {
//        let parameters = ["fields": "id, name, email, first_name, last_name, picture.type(large)"]
//        GraphRequest(graphPath: "me", parameters: parameters, accessToken: accessToken, httpMethod: .GET, apiVersion: .defaultVersion).start{ httpResponse, graphResult in
//
//            switch graphResult {
//            case .failed(let error):
//                completion(nil, error)
//            case .success(let graphResponse):
//                completion(graphResponse.dictionaryValue, nil)
//            }
//        }
//    }
//}



