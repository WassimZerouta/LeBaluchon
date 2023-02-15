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
    
    func performRequest(amount: String, completion: @escaping (Bool, Change?) -> Void) {
        
        if let urlString = getUrl(amount: amount) {
            let apiKey = ProcessInfo.processInfo.environment["SECRET_KEY_CHANGE_API"]!
            var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
            request.addValue("\(apiKey)", forHTTPHeaderField: "apikey")
            
            task = session.dataTask(with: request) {data, response, error in
                if let successData = data {
                    print(String(data: successData, encoding: .utf8)!)
                    let decoder = JSONDecoder()
                    do{
                        let results = try decoder.decode(ChangeAPIResult.self, from: successData)
                        completion(true, Change(value: results.result))
                    } catch {
                        print(error)
                    }
                } else {
                    completion(false, nil)
                }
            }
            task?.resume()
        } else
        {
            completion(false, nil)
        }
    }
        
    }
