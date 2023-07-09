//
//  ChangeTestCase.swift
//  LeBaluchonTests
//
//  Created by Wass on 11/02/2023.
//

import XCTest

@testable import LeBaluchon

final class ChangeTestCase: XCTestCase {

    func testGetChangeShouldPostFailedCallBackError() {
        //Given
        let ChangeAPIHelper = ChangeAPIHelper(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        //When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        ChangeAPIHelper.performRequest(amount: "23") { success, change in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(change)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
     }
     
     func testGetChangeShouldPostFailedCallBackIfNoData() {
         //Given
         let ChangeAPIHelper = ChangeAPIHelper(session: URLSessionFake(data: nil, response: nil, error: nil))
         //When
         let expectation = XCTestExpectation(description: "Wait for queu change")
         ChangeAPIHelper.performRequest(amount: "23") { success, change in
             //Then
             XCTAssertFalse(success)
             XCTAssertNil(change)
             expectation.fulfill()
         }
         wait(for: [expectation], timeout: 0.01)
      }
     
     func testGetChangeShouldPostFailedCallBackIfIncorrectResponse() {
         //Given
         let ChangeAPIHelper = ChangeAPIHelper(session: URLSessionFake(data: FakeResponseData.changeCorrectData, response: FakeResponseData.changeResponseKO, error: nil))
         //When
         let expectation = XCTestExpectation(description: "Wait for queu change")
         ChangeAPIHelper.performRequest(amount: "23") { success, change in
             //Then
             XCTAssertFalse(success)
             XCTAssertNil(change)
             expectation.fulfill()
         }
         wait(for: [expectation], timeout: 0.01)

      }
     
     func testGetChangeShouldPostFailedCallBackIfInccorectData() {
         //Given
         let ChangeAPIHelper = ChangeAPIHelper(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.changeResponseOk, error: nil))
         //When
         let expectation = XCTestExpectation(description: "Wait for queu change")
         ChangeAPIHelper.performRequest(amount: "23") { success, change in
             //Then
             XCTAssertFalse(success)
             XCTAssertNil(change)
             expectation.fulfill()
         }
         wait(for: [expectation], timeout: 0.01)
      }
     
    func testGetChangeShouldPostSuccessCallBackIfNoErrorAndCorrectData() {
        //Given
        let ChangeAPIHelper = ChangeAPIHelper(session: URLSessionFake(data: FakeResponseData.changeCorrectData, response: FakeResponseData.changeResponseOk, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        ChangeAPIHelper.performRequest(amount: "23") { success, change in
            //Then
            XCTAssertTrue(success)
            XCTAssertNotNil(change)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
        
    }


}
