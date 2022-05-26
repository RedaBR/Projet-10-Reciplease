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
        let translate = RecipleaseService(session:URLSessionFake(data: <#T##Data?#>, error: <#T##Error?#>, response: <#T##URLResponse?#>)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translate.getTranslate(text:nil) {(data, success)in
        // Then
        XCTAssertFalse(success)
        XCTAssertNil(data)
        expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func testGetRecipeShouldPostFailedCallbackIfNoData() {
        // Given
        let translate = RecipleaseService(session:URLSessionFake(data:nil, error:nil, response:nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translate.getTranslate(text: nil) {(data, success)in
        
        // Then
        XCTAssertFalse(success)
        XCTAssertNil(data)
        expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipeShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let translate = RecipleaseService(session:URLSessionFake(data:FakeResponseDate().correctTranslateData, error:nil, response:FakeResponseDate().responseKO))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translate.getTranslate(text: nil) {(data, success)in
        // Then
        XCTAssertTrue(success)
        XCTAssertNotNil(data)
        expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipeShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let translate = RecipleaseService(session:URLSessionFake(data:FakeResponseDate().incorrectData, error:nil, response:FakeResponseDate().responseOK))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translate.getTranslate(text: nil) {(data, success)in
        // Then
        XCTAssertFalse(success)
        XCTAssertNil(data)
        expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let translatedText = "the big tower"
        // Given
        let translate = RecipleaseService(session:URLSessionFake(data:FakeResponseDate().correctTranslateData, error:nil, response:FakeResponseDate().responseOK))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translate.getTranslate(text:translatedText) {(succes,data)in
        
        // Then
        XCTAssertTrue((succes != nil))
        XCTAssertNotNil(data)
        expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}
