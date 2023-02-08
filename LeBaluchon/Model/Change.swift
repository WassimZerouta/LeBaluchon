//
//  Change.swift
//  LeBaluchon
//
//  Created by Wass on 04/02/2023.
//

import Foundation

class Change {
    
    let value: Double
    
    func roundedValue() -> Double {
       let roundedVal =  round(value)
        return roundedVal
    }
    
    init(value: Double) {
        self.value = value
    }
}
