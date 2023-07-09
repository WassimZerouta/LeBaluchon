//
//  TranslateAPIHelper.swift
//  LeBaluchon
//
//  Created by Wass on 04/02/2023.
//

import Foundation

class TranslateAPIHelper {
    
    static let shared = TranslateAPIHelper(session: URLSession(configuration: .default))
    
    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    let apiKey = ProcessInfo.processInfo.environment["SECRET_KEY_TRANSLATE_API"]!
    let baseUrl = "https://translation.googleapis.com/language/translate/v2?"
    
    // Construct the URL for the API call
    func getUrl(q: String, source: String, target: String) -> String? {
        var url = baseUrl
        url += apiKey
        url += "&source=\(source)"
        url += "&target=\(target)"
        url += "&q=\(q)"
        
        return url
    }
    
    // Perform the API call
    func performRequest(q: String, source: String, target: String, completion: @escaping (Bool, Translate?) -> Void) {
        
        if let urlString = getUrl(q: q, source: source , target: target ) {
            let url = URL(string: urlString.replacingOccurrences(of: " ", with: "%20"))!
            
            task = session.dataTask(with: url) {data, response, error in
                
                guard let data = data, error == nil else { completion(false, nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(false, nil)
                    return
                    
                }
                
                let decoder = JSONDecoder()
                
                guard let results = try? decoder.decode(TranslateAPIResult.self, from: data) else {
                    completion(false, nil)
                    return
                }
                completion(true, Translate(trad: results.data.translations[0].translatedText))
            }
            task?.resume()
        } else
        {
            completion(false, nil)
        }
    }
    
}
