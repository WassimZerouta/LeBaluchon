//
//  ChangeAPIHelper.swift
//  LeBaluchon
//
//  Created by Wass on 04/02/2023.
//

import Foundation

class ChangeAPIHelper {
    
    static let shared = ChangeAPIHelper()
    
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
    
    func performRequest(amount: String, completion: @escaping (Change?) -> Void) {
        
        if let url = getUrl(amount: amount) {
            var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
            request.addValue("aUWaQwgLccRn8kjLZlBnRQg0psvTdyVJ", forHTTPHeaderField: "apikey")
            
            URLSession.shared.dataTask(with: request) {data, response, error in
                if let successData = data {
                    print(String(data: successData, encoding: .utf8)!)
                    let decoder = JSONDecoder()
                    do{
                        let results = try decoder.decode(ChangeAPIResult.self, from: successData)
                        completion(Change(value: results.result))
                    } catch {
                        print(error)
                    }
                } else {
                    completion(nil)
                }
            }.resume()
        } else
        {
            completion(nil)
        }
    }
        
    }
