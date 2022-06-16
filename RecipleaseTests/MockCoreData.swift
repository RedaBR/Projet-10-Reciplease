//
//  MockCoreData.swift
//  RecipleaseTests
//
//  Created by Reda on 07/06/2022.
//
// MARK: - Gestions Test Core Data

import Foundation
import CoreData
@testable import Reciplease

class MockCoreData {
// MARK: - managedObjectContextLazy
    lazy var managedObjectContextLazy: NSManagedObjectContext = {
// Access to PersistentStoreCoordinator
        let coordinator = self.persistentStoreCoordinator
        let managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        return managedObjectModel
    }()
    // MARK: - persistentStoreCoordinator
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        var coordinator: NSPersistentStoreCoordinator? =
            // initialisation model to elements saved
            NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        do {// sava in memory
            try coordinator!.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            coordinator = nil
            print("Error")
        }
        return coordinator
    }()

    // MARK: - persistentStoreCoordinator
    // Context from instance persistentStoreCoordinator
    var viewContext: NSManagedObjectContext {
        return managedObjectContextLazy
    }
}
