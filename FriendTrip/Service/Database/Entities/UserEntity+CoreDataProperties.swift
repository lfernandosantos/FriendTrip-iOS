//
//  UserEntity+CoreDataProperties.swift
//  
//
//  Created by Luiz Fernando dos Santos on 03/12/18.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var faceID: String?
    @NSManaged public var name: String?
    @NSManaged public var imagePath: String?
    @NSManaged public var email: String?

}
