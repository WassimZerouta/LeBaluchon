//
//  WeatherTestCase.swift
//  LeBaluchonTests
//
//  Created by Wass on 10/02/2023.
//

import XCTest

@testable import LeBaluchon

final class WeatherTestCase: XCTestCase {

   func testGetWeatherShouldPostFailedCallBackError() {
       //Given
       let WeatherAPIHelper = WeatherAPIHelper(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
       //When
       let expectation = XCTestExpectation(description: "Wait for queu change")
       WeatherAPIHelper.performRequest(coords: "&lon=-122.40&lat=37.78") { success, weather in
           //Then
           XCTAssertFalse(success)
           XCTAssertNil(weather)
           expectation.fulfill()
       }
       wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallBackIfNoData() {
        //Given
        let WeatherAPIHelper = WeatherAPIHelper(session: URLSessionFake(data: nil, response: nil, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        WeatherAPIHelper.performRequest(coords: "&lon=-122.40&lat=37.78") { success, weather in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
     }
    
    func testGetWeatherShouldPostFailedCallBackIfIncorrectResponse() {
        //Given
        let WeatherAPIHelper = WeatherAPIHelper(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.weatherResponseKO, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        WeatherAPIHelper.performRequest(coords: "")
        { success, weather in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)

     }
    
    func testGetWeatherShouldPostFailedCallBackIfInccorectData() {
        //Given
        let WeatherAPIHelper = WeatherAPIHelper(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.weatherResponseOk, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        WeatherAPIHelper.performRequest(coords: "&lon=-122.40&lat=37.78") { success, weather in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()

        }
        wait(for: [expectation], timeout: 0.1)

     }
    
    func testGetWeatherShouldPostSuccessCallBackIfNoErrorAndCorrectData() {
        //Given
        let WeatherAPIHelper = WeatherAPIHelper(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.weatherResponseOk, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        WeatherAPIHelper.performRequest(coords: "&lon=-122.40&lat=37.78") { success, weather in
            //Then
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
     }
}
