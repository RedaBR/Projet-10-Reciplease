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
        let properties = CoreDataRecipe(context: CoreDataStack.sharedInstance.viewContext)
        properties.uri = "toto"
        
        do {
             try CoreDataStack.sharedInstance.viewContext.save()
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
             try CoreDataStack.sharedInstance.viewContext.save()
        }
        catch {
            print(error.localizedDescription)
        }
        CoreDataStack.sharedInstance.getProperties { (recipes) in
            object = recipes.first!
        }
        CoreDataStack.sharedInstance.delete(recipeToDelete:object)
        
        CoreDataStack.sharedInstance.getProperties { (recipe) in
            XCTAssertFalse(recipe.first?.uri == "toto")
        }
     
    }
    
}
