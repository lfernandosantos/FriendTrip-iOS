//
//  Dictionary+Codable.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 17/07/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import Foundation

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
