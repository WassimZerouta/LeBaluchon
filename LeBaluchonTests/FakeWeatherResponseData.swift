//
//  FakeWeatherResponseData.swift
//  LeBaluchonTests
//
//  Created by Wass on 10/02/2023.
//

import Foundation

class FakeWeatherResponseData {
    
    static let responseOk = HTTPURLResponse(url: URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=1f3aa604e289c99c611abb6afd24872d&units=metric&lang=fr&lon=-122.406417&lat=37.785834")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    
    static let responseKO = HTTPURLResponse(url: URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=1f3aa604e289c99c611abb6afd24872d&units=metric&lang=fr&lon=-122.406417&lat=37.785834")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    class WeatherError: Error {}
    
    static let error = WeatherError()
    
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeWeatherResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let weatherIncorrectData = "erreur".data(using: .utf8)
}
