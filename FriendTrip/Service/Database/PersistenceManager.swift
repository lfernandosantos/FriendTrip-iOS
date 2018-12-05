//
//  PersistenceService.swift
//  FriendTrip
//
//  Created by Luiz Fernando dos Santos on 03/12/18.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import Foundation
import CoreData

class PersistenceManager {

    private init() { }

    static let shared = PersistenceManager()

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "FriendTrip")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var context = persistentContainer.viewContext

    func save () {
        if context.hasChanges {
            do {
                try context.save()
                print("save core data")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    internal func cleanDB<T: NSManagedObject>(_ objectType: T.Type) {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            print("Clean Core Data >>>>>>")
        }catch (let error) {
            print(error)
        }
    }

    func fetch<T: NSManagedObject> (_ objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch (let error) {
            print(error)
            return [T]()
        }
    }
}
