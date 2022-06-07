//
//  CoreDataRecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Reda on 26/05/2022.
//

import XCTest
@testable import Reciplease

class CoreDataRecipleaseTests: XCTestCase {

    func testGetProperties () {
// initialisation du context de CoreDataRecipe qui herite de NSManagedObject qui a  un init context de type NSManagedObjectContext
        
        let properties = CoreDataRecipe(context: CoreDataStack.sharedInstance.viewContext)
        properties.uri = "toto"
        do {
             try MockCoreData().viewContext.save()
        }
        catch {
            print(error.localizedDescription)
        }
        CoreDataStack.sharedInstance.getProperties { (recipes) in
            XCTAssertEqual(recipes.count>0,properties.uri == "toto")
        }
     
    }
    
    func testDeleteRecipeToDataBase () {
        let properties = CoreDataRecipe(context: CoreDataStack.sharedInstance.viewContext)
        properties.uri = "toto"
        var object = CoreDataRecipe()
        do {
             try MockCoreData().viewContext.save()
        }
        catch {
            print(error.localizedDescription)
        }
        CoreDataStack.sharedInstance.getPropertieWithTitle(uri: properties.uri!, completion: {(recipes) in
            object = recipes.first!
        })
        CoreDataStack.sharedInstance.delete(recipeToDelete:object)
        
        CoreDataStack.sharedInstance.getProperties { (recipe) in
            XCTAssertFalse(recipe.first?.uri == "toto")
        }
    }
}
