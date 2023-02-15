//
//  MeteoAPIHelper.swift
//  LeBaluchon
//
//  Created by Wass on 04/02/2023.
//

import Foundation

class WeatherAPIHelper {
    
    static let shared = WeatherAPIHelper(session: URLSession(configuration: .default))
    
    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    let apiKey = ProcessInfo.processInfo.environment["SECRET_KEY_WEATHER_API"]!
    let baseURL = "https://api.openweathermap.org/data/2.5/weather?"
    
    
    func getUrl(coords: String) -> String? {
        var url = baseURL
        url += apiKey
        url += "&units=metric&lang=fr"
        let urlString = url + coords
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
                        let results = try decoder.decode(WeatherAPIResult.self, from: successData)
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
