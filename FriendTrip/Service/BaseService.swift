//
//  BaseService.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 23/11/18.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation
import Alamofire

protocol BaseService {
    func request(endpoint: RequestData, completionHandler: @escaping (RequestResult<Any, String>) -> Void )
}

extension BaseService {
    func request(endpoint: RequestData, completionHandler: @escaping (RequestResult<Any, String>) -> Void ){

        if endpoint.method == .post {

            Alamofire.request( endpoint.path,
                              method: .post,
                              parameters: endpoint.params,
                              encoding: JSONEncoding(),
                              headers: endpoint.headers).responseJSON { result in

                                switch result.result {
                                case .success(let valueResponse):
                                    completionHandler(RequestResult.success(valueResponse))
                                case .failure(let error):
                                    completionHandler(RequestResult.failure(error.localizedDescription))
                                }
            }
        }
    }
}
