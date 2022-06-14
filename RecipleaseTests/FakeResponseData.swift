//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Reda on 26/05/2022.
//

import Foundation

class FakeResponseDate {
    
// MARK: - Data
    var correctTranslateData : Data {
        //identifying the bundle that contains the FakeResponseData class file
        let bundle = Bundle.init(for: FakeResponseDate.self)
        // identification of the url of the file which contains the data in json imported from postman
        let url = bundle.url(forResource: "RecipeData", withExtension: "json")
        // Retrieval of data contained at the url via the Data initiator
        let data = try? Data(contentsOf: url!)
        return data!
    }
    
  // Encoding of a String value the method return a Data type value
    let incorrectData = "erreur".data(using: .utf8)
    let imageData = "image".data(using: .utf8)
    
    // MARK: - Response

   // Creation of 2 instances of HTTPURLResponse to test cases of error related to bad code
    let responseOK = HTTPURLResponse(url: URL(string: "http://googl.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    
    let responseKO = HTTPURLResponse(url: URL(string: "http://googl.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
     
    // MARK: - ERROR
    
    // Access To Error
    class DataError : Error {}
    static let error = DataError()
}
