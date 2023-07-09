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
    
    func displayTemperature(temperature: Double) -> String {
        let intTemperature = Int(temperature)
        let temp = "\(intTemperature)°C"
        return temp
    }
    
    init(temperature: Double, description: String, city: String) {
        self.temperature = temperature
        self.description = description
        self.city = city
    }
}
