//
//  CoreDataRecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Reda on 26/05/2022.
//

import XCTest
@testable import Reciplease

class CoreDataRecipleaseTests: XCTestCase {
    
    // MARK: - Get Recipes
    func testGetProperties () {        
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
    
    // MARK: - Delete Recipes

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
