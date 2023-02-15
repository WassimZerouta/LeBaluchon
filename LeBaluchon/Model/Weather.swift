//
//  Meteo.swift
//  LeBaluchon
//
//  Created by Wass on 04/02/2023.
//

import Foundation

class Meteo {
    
    let temperature: Double
    let description: String
    let city: String
    
    init(temperature: Double, description: String, city: String) {
        self.temperature = temperature
        self.description = description
        self.city = city
    }
}
