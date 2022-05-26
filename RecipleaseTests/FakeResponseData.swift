//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Reda on 26/05/2022.
//

import Foundation
class FakeResponseDate {
//MARK : - Data
    var correctTranslateData : Data {
        
        // identification du bundle qui contient le fichier de la classe FakeResponseData
        let bundle = Bundle.init(for: FakeResponseDate.self)
        // identification de l'url du fichier qui contient les donnés en json importé de postman
        let url = bundle.url(forResource: "RecipeData", withExtension: "json")
        //Recuperation des donnés contenue a l'url via l'initiateur Data
        let data = try? Data(contentsOf: url!)
        
        return data!
    }
  // encodage d'une valeur String la methode renvoir une valeur de type Data
    let incorrectData = "erreur".data(using: .utf8)
    let imageData = "image".data(using: .utf8)
    
//MARK : - Response
    // creation de 2 instance de HTTPURLResponse pour tester les cas d'erreur lié a un mauvais code 
    let responseOK = HTTPURLResponse(url: URL(string: "http://googl.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    
    let responseKO = HTTPURLResponse(url: URL(string: "http://googl.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
     
//MARK : - Error
    // Accés a la classe Error
    class DataError : Error {}
    static let error = DataError()
    
  
    
  
}
