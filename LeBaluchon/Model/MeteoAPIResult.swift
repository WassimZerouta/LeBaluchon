//
//  MeteoAPIResult.swift
//  LeBaluchon
//
//  Created by Wass on 04/02/2023.
//

import Foundation

struct MeteoAPIResult: Decodable {
    var list: [Forecast]
}

struct Forecast: Decodable {
    var dt: Int
    var main: Main
    var weather: [Weather]
    var dt_txt: String
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

