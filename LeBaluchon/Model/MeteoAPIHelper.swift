//
//  MeteoAPIHelper.swift
//  LeBaluchon
//
//  Created by Wass on 04/02/2023.
//

import Foundation

class MeteoAPIHelper {
    
    static let shared = MeteoAPIHelper()
    
    let baseURL = "https://api.openweathermap.org/data/2.5/forecast&appid=621bd2fdb72285815bbbc4a732a9d250&units=metric&lang=fr"
    
    
    func getUrlString(coords: String) -> String? {
        let shared = MeteoAPIHelper()
        let urlString = shared.baseURL+coords
        print(urlString)
        return urlString
    }
    
    func parsehWeather(coords: String,  completion: @escaping (Meteo?) -> Void) {
        if let urlString = getUrlString(coords: coords) {
            let Url = URL(string: urlString)
            URLSession.shared.dataTask(with: Url!) { data, response, error in
                if let successData = data {
                    let decoder = JSONDecoder()
                    do {
                        let results = try decoder.decode(MeteoAPIResult.self, from: successData)
                        completion(Meteo(temperature: results.list[0].main.temp, description: results.list[0].weather.description))
                    } catch {
                        print(error)
                    }
                } else {
                    completion(nil)
                }
            }.resume()
        }
        else {
                
            completion(nil)
                
            }
    }
    
    }
