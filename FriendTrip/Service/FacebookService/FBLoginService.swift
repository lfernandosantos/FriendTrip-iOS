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




