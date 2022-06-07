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

// class pour gerer les test CoreDatata
class MockCoreData {
  
// MARK: - managedObjectContextLazy
    lazy var managedObjectContextLazy: NSManagedObjectContext = {
// creation d'une variable calculée  de type NSManagedObjectContext pour accéder a son ppersistentStoreCoordinator
        let coordinator = self.persistentStoreCoordinator
        let managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // merge du model qui se trouve dans le budle du fichier centrale
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        return managedObjectModel
    }()
    
    // MARK: - persistentStoreCoordinator
    
    //Gestions du NSNSPersistentStoreCoordinator pour enrengistere les éléments sur la mémoire et non sur le disque
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        var coordinator: NSPersistentStoreCoordinator? =
            // initialisation du modéle avec les élements a enregistré
            NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        do {// initialisation pour enregistrer les élemenst sur la mémoire
            try coordinator!.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        }
        catch {
            coordinator = nil
            print("Error")
        }
        return coordinator
    }()
    
    // MARK: - persistentStoreCoordinator
    // creations d'une variable calculée qui renvoi le managedObjectContextLazy
    var viewContext : NSManagedObjectContext {
        return managedObjectContextLazy
    }
    
}
