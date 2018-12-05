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

extension UserEntity {
    
    func alreadyExists() -> Bool {
        let persistence = PersistenceManager.shared
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")

        guard let faceID = self.faceID else {
            return false
        }

        fetchRequest.predicate = NSPredicate(format: "faceID=%@", faceID)
        do {
            let results = try persistence.context.fetch(fetchRequest) as? [UserEntity]
            if (results?.count == 0) {
                return false
            } else {
                return true
            }
        } catch (let error) {
            print(error)
            return false
        }
    }

    func saveOnDB() {
        let persistence = PersistenceManager.shared

        if !self.alreadyExists() {
            let entity = UserEntity(context: persistence.context)
            entity.faceID = self.faceID
            entity.name = self.name
            entity.email = self.email
            entity.imagePath = self.imagePath

            persistence.save()
        }
    }
}
