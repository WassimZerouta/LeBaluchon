//
//  TranslateTestCase.swift
//  LeBaluchonTests
//
//  Created by Wass on 11/02/2023.
//

import XCTest
@testable import LeBaluchon

final class TranslateTestCase: XCTestCase {

    func testGetTranslateShouldPostFailedCallBackError() {
        //Given
        let TranslateAPIHelper = TranslateAPIHelper(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        //When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        TranslateAPIHelper.performRequest(q: "Bonjour", source: "fr", target: "en") { success, translate in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
     }
     
     func testGetTranslateShouldPostFailedCallBackIfNoData() {
         //Given
         let TranslateAPIHelper = TranslateAPIHelper(session: URLSessionFake(data: nil, response: nil, error: nil))
         //When
         let expectation = XCTestExpectation(description: "Wait for queu change")
         TranslateAPIHelper.performRequest(q: "Bonjour", source: "fr", target: "en") { success, translate in
             //Then
             XCTAssertFalse(success)
             XCTAssertNil(translate)
             expectation.fulfill()
         }
         wait(for: [expectation], timeout: 0.01)
      }
     
     func testGetTranslateShouldPostFailedCallBackIfIncorrectResponse() {
         //Given
         let TranslateAPIHelper = TranslateAPIHelper(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.changeResponseKO, error: nil))
         //When
         TranslateAPIHelper.performRequest(q: "Bonjour", source: "fr", target: "en") { success, translate in
             //Then
             XCTAssertFalse(success)
             XCTAssertNil(translate)
         }
      }
     
     func testGetTranslateShouldPostFailedCallBackIfInccorectData() {
         //Given
         let TranslateAPIHelper = TranslateAPIHelper(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.changeResponseOk, error: nil))
         //When
         TranslateAPIHelper.performRequest(q: "Bonjour", source: "fr", target: "en") { success, translate in
             //Then
             XCTAssertFalse(success)
             XCTAssertNil(translate)
         }
      }
     
    func testGetTranslateShouldPostSuccessCallBackIfNoErrorAndCorrectData() {
        //Given
        let TranslateAPIHelper = TranslateAPIHelper(session: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.changeResponseOk, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        TranslateAPIHelper.performRequest(q: "Bonjour", source: "fr", target: "en") { success, translate in
            //Then
            XCTAssertTrue(success)
            XCTAssertNotNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
        
    }
}
