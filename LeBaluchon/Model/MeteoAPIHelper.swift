//
//  MeteoAPIHelper.swift
//  LeBaluchon
//
//  Created by Wass on 04/02/2023.
//

import Foundation

class MeteoAPIHelper {
    
    static let shared = MeteoAPIHelper(session: URLSession(configuration: .default))
    
    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    let baseURL = "https://api.openweathermap.org/data/2.5/weather?appid=1f3aa604e289c99c611abb6afd24872d&units=metric&lang=fr"
    
    
    func getUrl(coords: String) -> String? {
        let urlString = baseURL+coords
        print(urlString)
        return urlString
    }
    
    func performRequest(coords: String,  completion: @escaping (Bool, Meteo?) -> Void) {
        
        if let urlString = getUrl(coords: coords) {
            print(urlString)
            let Url = URL(string: urlString)
            task = session.dataTask(with: Url!) { data, response, error in
                if let successData = data {
                    let decoder = JSONDecoder()
                    do {
                        let results = try decoder.decode(MeteoAPIResult.self, from: successData)
                        completion(true, Meteo(temperature: results.main.temp, description: results.weather[0].description, city: results.name))
                    } catch {
                        print(error)
                    }
                } else {
                    completion(false, nil)
                }
            }
            task?.resume()
        }
        else {
                
            completion(false, nil)
                
            }
    }
    
    }
