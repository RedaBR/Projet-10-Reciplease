//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Reda on 12/05/2022.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let sharedInstance = CoreDataStack()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Reciplease")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var viewContext : NSManagedObjectContext {
        return CoreDataStack.sharedInstance.persistentContainer.viewContext
    }
    
    private init() {}
    
    func getProperties(completion: ([CoreDataRecipe]) -> Void) {
        let request: NSFetchRequest<CoreDataRecipe> = CoreDataRecipe.fetchRequest()
        do {
            let properties = try CoreDataStack.sharedInstance.viewContext.fetch(request)
            completion(properties)
        } catch {
            completion([])
        }
    }
    
    func getPropertieWithTitle(title:String, completion: ([CoreDataRecipe]) -> Void) {
        let request: NSFetchRequest<CoreDataRecipe> = CoreDataRecipe.fetchRequest()
        
        request.predicate = NSPredicate(format: "title == %@", title)
        do {
            let properties = try CoreDataStack.sharedInstance.viewContext.fetch(request)
            try CoreDataStack.sharedInstance.viewContext.save()
            completion(properties)
        } catch {
            completion([])
        }
    }
    
    func replace(sameRecipe:NSManagedObject) {
        let request: NSFetchRequest<CoreDataRecipe> = CoreDataRecipe.fetchRequest()
        do {
            let properties = try CoreDataStack.sharedInstance.viewContext.insert(sameRecipe)
            try CoreDataStack.sharedInstance.viewContext.save()
        }
        catch {
            
        }
        
    }
    
    func delete (recipeToDelete:NSManagedObject) {
        
            let request: NSFetchRequest<CoreDataRecipe> = CoreDataRecipe.fetchRequest()
            do {
                let properties = try CoreDataStack.sharedInstance.viewContext.delete(recipeToDelete)
                try CoreDataStack.sharedInstance.viewContext.save()
            }
            catch {
                
            }
    }
}
