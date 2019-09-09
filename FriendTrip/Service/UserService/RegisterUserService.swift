//
//  RegisterUserService.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 23/11/18.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation

enum FacebookParameters: String {
    case FACEBOOKID = "facebookID"
    case FACENAME = "name"
}

struct RegisterUserService: BaseService {
    internal func registerUser(facebookID: String,
                               name: String,
                               completionHandler: @escaping(RequestResult<Any, String>) -> Void ) {

        let endpoint = RequestData(path: .register,
                                   method: .post,
                                   params: [FacebookParameters.FACEBOOKID.rawValue: facebookID,
                                            FacebookParameters.FACENAME.rawValue: name])

        self.request(endpoint: endpoint) { result in
            switch result {
            case .success( let json):
                completionHandler(RequestResult.success(json))
            case .failure( let errorMsg):
                completionHandler(RequestResult.failure(errorMsg))
            }
        }
    }
}
