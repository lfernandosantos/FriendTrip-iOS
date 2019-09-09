//
//  LoginViewModel.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 02/12/18.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit

protocol LoginViewModelProtocol {
    func login( completionHandler: @escaping ((RequestResult<Bool, String>) -> Void))
}

protocol LoginViewModelDelegate {
    func didLogin(result: RequestResult<Bool, String?>)
}

class LoginViewModel: NSObject {

    var user            : User?
    var loginDelegate   : LoginViewModelDelegate?
    let facebookService : LoginFBRequestProtocol

    var userSerivice: FirebaseUserServiceProtocol? {
        guard let user = self.user else { return nil}
        return FirebaseUserService(user: user)
    }

    init(facebookService: LoginFBRequestProtocol = LoginFBRequest()) {
        self.facebookService = facebookService
    }
    
    func saveUser(user: User) {
        guard let userDictionary = user.dictionary else {
            return
        }
        UserDefaultManager().saveUserDefault(userDictionary, for: "user")
    }

    func getUser() -> User? {
        let userData = UserDefaultManager().loadFromUserDefault(key: "user")
        
        guard let userDictionary = userData as? [String: Any] else {
            return nil
        }
        
        return User.from(dictionary: userDictionary)
    }

    func logoutUser() {
        UserDefaultManager().deleteToUserDefault(key: "user")
    }
    
    private func getUserFacebookInfo(token: AccessToken, completion: @escaping (Bool) -> Void) {
        facebookService.getUserInfo(accessToken: token) { (value, error) in
            
            guard let json = value else {
                print(error.debugDescription)
                //TODO: Remove token
                completion(false)
                return
            }
            
            guard let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else {
                print("Error to json serializable data.")
                completion(false)
                return
            }
            
            guard let user = try? JSONDecoder().decode(User.self, from: data) else {
                print("Error to decode serializable.")
                completion(false)
                return
            }
            
            self.saveUser(user: user)
            self.user = user
            completion(true)
        }
    }

}

extension LoginViewModel: LoginButtonDelegate {
    
    func alreadyLogin(completion: @escaping (Bool) -> Void) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime.now() + 4) {
            if let token = AccessToken.current {
                self.getUserFacebookInfo(token: token, completion: completion)
            } else {
                completion(false)
            }
        }
        
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if error != nil {
            self.loginDelegate?.didLogin(result: RequestResult.failure(error.debugDescription))
            return
        }
        
        guard let result = result else {
            self.loginDelegate?.didLogin(result: RequestResult.failure("Error"))
            return
        }
        
        if result.isCancelled {
            self.loginDelegate?.didLogin(result: RequestResult.failure("Is Cancelled"))
            return
        }
        
        guard let token = result.token else {
            self.loginDelegate?.didLogin(result: RequestResult.failure("Error"))
            return
        }
        
        self.getUserFacebookInfo(token: token) { (success) in
            if success {
                self.loginDelegate?.didLogin(result: RequestResult.success(true))
            } else {
                self.loginDelegate?.didLogin(result: RequestResult.failure("Error"))
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logout")
    }
}
