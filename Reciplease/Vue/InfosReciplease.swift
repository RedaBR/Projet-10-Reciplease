

import Foundation


// MARK: - InfosReciplease
class InfosReciplease: Codable {
    let from: Int
    let to: Int
    let count: Int
    let links: InfosRecipleaseLinks
    let hits: [Hit]

  
}

// MARK: - Hit
class Hit: Codable {
    let recipe: Recipe
    let links: HitLinks

   
}

// MARK: - HitLinks
class HitLinks: Codable {
    let linksSelf: Next


   
}

// MARK: - Next
class Next: Codable {
    let href: String
    let title: Title

   

}

enum Title: String, Codable {
    case nextPage = "Next page"
    case titleSelf = "Self"
}

// MARK: - Recipe
class Recipe: Codable {
    let uri: String
    let label: String
    let image: String
    let images: Images
    let source: String
    let url: String
    let shareAs: String
    let yield: Int
    let dietLabels: [DietLabel]
    let healthLabels: [String]
    let cautions: [String]
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let calories: Double
    let totalWeight: Double
    let totalTime: Int
    let cuisineType: [String]
    let mealType: [MealType]
    let dishType: [DishType]
    let totalNutrients: [String: Total]
    let totalDaily: [String: Total]
    let digest: [Digest]

   

    
}

enum DietLabel: String, Codable {
    case highFiber = "High-Fiber"
    case lowCarb = "Low-Carb"
}

// MARK: - Digest
class Digest: Codable {
    let label: String
    let tag: String
    let schemaOrgTag: SchemaOrgTag?
    let total: Double
    let hasRDI: Bool
    let daily: Double
    let unit: Unit
    let sub: [Digest]?

 

 
}

enum SchemaOrgTag: String, Codable {
    case carbohydrateContent = "carbohydrateContent"
    case cholesterolContent = "cholesterolContent"
    case fatContent = "fatContent"
    case fiberContent = "fiberContent"
    case proteinContent = "proteinContent"
    case saturatedFatContent = "saturatedFatContent"
    case sodiumContent = "sodiumContent"
    case sugarContent = "sugarContent"
    case transFatContent = "transFatContent"
}

enum Unit: String, Codable {
    case empty = "%"
    case g = "g"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}

enum DishType: String, Codable {
    case condimentsAndSauces = "condiments and sauces"
    case mainCourse = "main course"
    case salad = "salad"
    case starter = "starter"
}

// MARK: - Images
class Images: Codable {
    let thumbnail: Large
    let small: Large
    let regular: Large
    let large: Large?

   

   
}

// MARK: - Large
class Large: Codable {
    let url: String
    let width: Int
    let height: Int

  

}

// MARK: - Ingredient
class Ingredient: Codable {
    let text: String
    let quantity: Double
    let measure: String?
    let food: String
    let weight: Double
    let foodCategory: String
    let foodId: String
    let image: String?

   

}

enum MealType: String, Codable {
    case lunchDinner = "lunch/dinner"
}

// MARK: - Total
class Total: Codable {
    let label: String
    let quantity: Double
    let unit: Unit


  
}

// MARK: - InfosRecipleaseLinks
class InfosRecipleaseLinks: Codable {
    let next: Next
}

