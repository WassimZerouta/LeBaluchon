//
//  MeteoAPIHelper.swift
//  LeBaluchon
//
//  Created by Wass on 04/02/2023.
//

import Foundation

class MeteoAPIHelper {
    
    static let shared = MeteoAPIHelper()
    
    let baseURL = "https://api.openweathermap.org/data/2.5/forecast&appid=1f3aa604e289c99c611abb6afd24872d&units=metric&lang=fr"
    
    
    func getUrl(coords: String) -> String? {
        let shared = MeteoAPIHelper()
        let urlString = shared.baseURL+coords
        print(urlString)
        return urlString
    }
    
    func performRequest(coords: String,  completion: @escaping (Bool, Meteo?) -> Void) {
        if let urlString = getUrl(coords: coords) {
            print(urlString)
            let Url = URL(string: urlString)
            URLSession.shared.dataTask(with: Url!) { data, response, error in
                if let successData = data {
                    let decoder = JSONDecoder()
                    do {
                        let results = try decoder.decode(MeteoAPIResult.self, from: successData)
                        completion(true, Meteo(temperature: results.list[0].main.temp, description: results.list[0].weather.description))
                    } catch {
                        print(error)
                    }
                } else {
                    completion(false, nil)
                }
            }.resume()
        }
        else {
                
            completion(false, nil)
                
            }
    }
    
    }
