//
//  TranslateAPIResult.swift
//  LeBaluchon
//
//  Created by Wass on 04/02/2023.
//

import Foundation

struct TranslateAPIResult: Decodable {
    var data: Data
}

struct Data: Decodable {
    var translations: [Translations]
}

struct Translations: Decodable {
    var translatedText: String
}
