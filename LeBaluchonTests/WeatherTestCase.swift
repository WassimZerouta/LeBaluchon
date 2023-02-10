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
       let MeteoAPIHelper = MeteoAPIHelper(session: URLSessionWeatherFake(data: nil, response: nil, error: FakeWeatherResponseData.error))
       //When
       let expectation = XCTestExpectation(description: "Wait for queu change")
       MeteoAPIHelper.performRequest(coords: "&lon=-122.40&lat=37.78") { success, weather in
           //Then
           XCTAssertFalse(success)
           XCTAssertNil(weather)
           expectation.fulfill()
       }
       wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallBackIfNoData() {
        //Given
        let MeteoAPIHelper = MeteoAPIHelper(session: URLSessionWeatherFake(data: nil, response: nil, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        MeteoAPIHelper.performRequest(coords: "&lon=-122.40&lat=37.78") { success, weather in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
     }
    
    func testGetWeatherShouldPostFailedCallBackIfIncorrectResponse() {
        //Given
        let MeteoAPIHelper = MeteoAPIHelper(session: URLSessionWeatherFake(data: FakeWeatherResponseData.weatherIncorrectData, response: FakeWeatherResponseData.responseKO, error: nil))
        //When
        MeteoAPIHelper.performRequest(coords: "&lon=-122.40&lat=37.78") { success, weather in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
        }
     }
    
    func testGetWeatherShouldPostFailedCallBackIfInccorectData() {
        //Given
        let MeteoAPIHelper = MeteoAPIHelper(session: URLSessionWeatherFake(data: FakeWeatherResponseData.weatherIncorrectData, response: FakeWeatherResponseData.responseOk, error: nil))
        //When
        MeteoAPIHelper.performRequest(coords: "&lon=-122.40&lat=37.78") { success, weather in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)

        }
     }
    
    func testGetWeatherShouldPostSuccessCallBackIfNoErrorAndCorrectData() {
        //Given
        let MeteoAPIHelper = MeteoAPIHelper(session: URLSessionWeatherFake(data: FakeWeatherResponseData.weatherCorrectData, response: FakeWeatherResponseData.responseOk, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        MeteoAPIHelper.performRequest(coords: "&lon=-122.40&lat=37.78") { success, weather in
            //Then
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
     }

}
