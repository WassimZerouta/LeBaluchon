//
//  TranslateAPIHelper.swift
//  LeBaluchon
//
//  Created by Wass on 04/02/2023.
//

import Foundation

class TranslateAPIHelper {
    
    static let shared = TranslateAPIHelper()
    
    let baseUrl = "https://translation.googleapis.com/language/translate/v2?key=AIzaSyCwcNVALcY0pgBXcu1ezeyxfHaG_xB_m6I"
    let source = "fr"
    let target = "&=en"
    
    func getUrl(q: String) -> String? {
        var url = baseUrl
        url += "&source=\(source)"
        url += "&target=\(target)"
        url += "&q=\(q)"
        
        return url
    }
    
    func performRequest(q: String, completion: @escaping (Bool, Translate?) -> Void) {
        
        if let urlString = getUrl(q: q) {
            let url = URL(string: urlString)
            URLSession.shared.dataTask(with: url!) {data, response, error in
                if let successData = data {
                    print(String(data: successData, encoding: .utf8)!)
                    let decoder = JSONDecoder()
                    do{
                        let results = try decoder.decode(TranslateAPIResult.self, from: successData)
                        completion(true, Translate(trad: results.translatedText))
                    } catch {
                        print(error)
                    }
                } else {
                    completion(false, nil)
                }
            }.resume()
        } else
        {
            completion(false, nil)
        }
    }
        
    }
