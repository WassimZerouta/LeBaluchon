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
    
    // Construct the URL for the API call
    func getUrl(coords: String) -> String? {
        var url = baseURL
        url += apiKey
        url += "&units=metric&lang=fr"
        let urlString = url + coords
        print(urlString)
        return urlString
    }
    
    // Perform the API call
    func performRequest(coords: String,  completion: @escaping (Bool, Meteo?) -> Void) {
        
        if let urlString = getUrl(coords: coords) {
            let Url = URL(string: urlString)
            task = session.dataTask(with: Url!) { data, response, error in
                
                guard let data = data, error == nil else {
                    completion(false, nil)
                    return
                    
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(false, nil)
                    return
                    
                }
                let decoder = JSONDecoder()
                
                do {
                    guard let results = try? decoder.decode(WeatherAPIResult.self, from: data) else {
                        completion(false, nil)
                        return
                    }
                    completion(true, Meteo(temperature: results.main.temp, description: results.weather[0].description, city: results.name))
                }
            }
            task?.resume()
        }
        else {
            
            completion(false, nil)
            
        }
    }
    
}
