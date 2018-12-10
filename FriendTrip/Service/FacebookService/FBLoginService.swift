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


import UIKit

struct LoginFBRequest {

    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){

            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    print(result)
                } else {
                    print(error)
                }
            })
        }
    }

    internal func requestFBLogin(view: UIViewController, completionHandler: @escaping (RequestResult<Any, String>) -> Void) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: [ "email"], from: view) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    completionHandler(RequestResult.failure("Was cancelled"))
                } else if fbloginresult.grantedPermissions.contains("email") {
                    completionHandler(RequestResult.success(true))
                }
            } else {
                completionHandler(RequestResult.failure(error.debugDescription))

            }
        }
    }
}



