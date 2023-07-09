//
//  ChangeAPIHelper.swift
//  LeBaluchon
//
//  Created by Wass on 04/02/2023.
//

import Foundation

class ChangeAPIHelper {
    
    static let shared = ChangeAPIHelper(session: URLSession(configuration: .default))
    
    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    let baseUrl = "https://api.apilayer.com/fixer/convert"
    let from = "EUR"
    let to = "USD"
    
    // Construct the URL for the API call
    func getUrl(amount: String) -> String? {
        var url = baseUrl
        url += "?from="
        url += from
        url += "&to="
        url += to
        url += "&amount="
        url += amount
        
        return url
    }
    
    // Perform the API call
    func performRequest(amount: String, completion: @escaping (Bool, Change?) -> Void) {
        
        if let urlString = getUrl(amount: amount) {
            let apiKey = ProcessInfo.processInfo.environment["SECRET_KEY_CHANGE_API"]!
            var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
            request.addValue("\(apiKey)", forHTTPHeaderField: "apikey")
            
            task = session.dataTask(with: request) {data, response, error in
                guard let data = data, error == nil else { completion(false, nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(false, nil)
                    return
                    
                }
                
                let decoder = JSONDecoder()
                
                guard let results = try? decoder.decode(ChangeAPIResult.self, from: data) else {
                    completion(false, nil)
                    return
                }
                completion(true, Change(value: results.result))
                
            }
            task?.resume()
        } else
        {
            completion(false, nil)
        }
    }
    
}
