//
//  LoginViewController.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 02/12/18.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    var loginVM = LoginVM()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()

        loginVM.makeLogin(facebookID: "faceid") {
            print(self.loginVM.getUser())
        }

    }

    func setUp() {
        if FBSDKAccessToken.current() != nil {
            print("logged in")
        } else {
            print("not logged")
        }

        addFBLoginButton()
    }

    func addFBLoginButton(){
        let btnFace = FBSDKLoginButton()
        btnFace.readPermissions = [FacebookLoginParams.PROFILE.rawValue,
                                   FacebookLoginParams.EMAIL.rawValue,
                                   FacebookLoginParams.USER_FRIENDS.rawValue]
        btnFace.center = self.view.center
        btnFace.delegate = self
        self.view.addSubview(btnFace)
    }



}

extension LoginViewController : FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error.debugDescription)
        } else if result.isCancelled {
            print("is cancelled")

        } else {
            print(result.grantedPermissions.description)
            print(loginButton.readPermissions.description)
        }
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logout")
    }
}
