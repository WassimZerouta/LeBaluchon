//
//  MeteoAPIResult.swift
//  LeBaluchon
//
//  Created by Wass on 04/02/2023.
//

import Foundation


struct WeatherAPIResult: Decodable {
    var weather: [Weather]
    var main: Main
    var dt: Int
    var name: String
}

struct Main: Decodable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    
}

struct Weather: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

