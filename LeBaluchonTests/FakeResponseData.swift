//
//  FakeWeatherResponseData.swift
//  LeBaluchonTests
//
//  Created by Wass on 10/02/2023.
//

import Foundation

class FakeResponseData {
    
    static let weatherResponseOk = HTTPURLResponse(url: URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=1f3aa604e289c99c611abb6afd24872d&units=metric&lang=fr&lon=-122.406417&lat=37.785834")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    
    static let weatherResponseKO = HTTPURLResponse(url: URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=1f3aa604e289c99c611abb6afd24872d&units=metric&lang=fr&lon=-122.406417&lat=37.785834")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    static let translateResponseOk = HTTPURLResponse(url: URL(string: "https://translation.googleapis.com/language/translate/v2?key=AIzaSyBTabmbypWfe7794tX37oMPZnrdT4s3ha4&source=fr&target=en&q=Bonjour")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    
    static let translateResponseKO = HTTPURLResponse(url: URL(string: "https://translation.googleapis.com/language/translate/v2?key=AIzaSyBTabmbypWfe7794tX37oMPZnrdT4s3ha4&source=fr&target=en&q=Bonjour")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    static let changeResponseOk = HTTPURLResponse(url: URL(string: "https://api.apilayer.com/fixer/convert?from=EUR&to=USD&amount=1")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    
    static let changeResponseKO = HTTPURLResponse(url: URL(string: "https://api.apilayer.com/fixer/convert?from=EUR&to=USD&amount=1")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    
    
    class ErrorResponse: Error {}
    
    static let error = ErrorResponse()
    
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var translateCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var changeCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Change", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let incorrectData = "erreur".data(using: .utf8)
}
