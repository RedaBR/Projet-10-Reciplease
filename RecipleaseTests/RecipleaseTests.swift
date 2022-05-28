//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Reda on 03/05/2022.
//

import XCTest

@testable import Reciplease

class RecipleaseTests: XCTestCase {

    func testGetRecipeShouldPostFailedCallbackIfError() {
        // Given
        let recipe = RecipleaseService(session: URLSessionFake(data: nil, error: FakeResponseDate.error, response: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipe.getReciplease(ingredients:nil) { (data, success, error) in
            XCTAssertFalse(success)
            XCTAssertNil(data)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 4)
    }
    
    func testGetRecipeShouldPostFailedCallbackIfNoData() {
        // Given
        let recipe = RecipleaseService(session:URLSessionFake(data:nil, error:nil, response:nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipe.getReciplease(ingredients: nil) { (data, sucess, error) in
            // Then
            XCTAssertFalse(sucess)
            XCTAssertNil(data)
            expectation.fulfill()

        }
        
        wait(for: [expectation], timeout: 4)
    }
    
    func testGetRecipeShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let recipe = RecipleaseService(session:URLSessionFake(data:FakeResponseDate().correctTranslateData, error:nil, response:FakeResponseDate().responseKO))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipe.getReciplease(ingredients: nil) { (data, sucess, error) in
            // Then
            XCTAssertTrue(sucess)
            XCTAssertNotNil(data)
            expectation.fulfill()

        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetRecipeShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let recipe = RecipleaseService(session:URLSessionFake(data:FakeResponseDate().incorrectData, error:nil, response:FakeResponseDate().responseOK))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipe.getReciplease(ingredients: nil) { (data, success, error) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(data)
            expectation.fulfill()
        }
      
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let ingredients = "tomate"
        // Given
        let recipe = RecipleaseService(session:URLSessionFake(data:FakeResponseDate().correctTranslateData, error:nil, response:FakeResponseDate().responseOK))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipe.getReciplease(ingredients:ingredients) {(data,success,error)in
        
        // Then
        XCTAssertTrue((success != nil))
        XCTAssertNotNil(data)
        expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}
