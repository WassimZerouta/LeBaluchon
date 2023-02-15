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
    
    func getUrl(q: String, source: String, target: String) -> String? {
        var url = baseUrl
        url += apiKey
        url += "&source=\(source)"
        url += "&target=\(target)"
        url += "&q=\(q)"
        
        return url
    }
    
    func performRequest(q: String, source: String, target: String, completion: @escaping (Bool, Translate?) -> Void) {
        
        if let urlString = getUrl(q: q, source: source , target: target ) {
            print(urlString)
            let url = URL(string: urlString)
            task = session.dataTask(with: url!) {data, response, error in
                if let successData = data {
                    print(String(data: successData, encoding: .utf8)!)
                    let decoder = JSONDecoder()
                    do{
                        let results = try decoder.decode(TranslateAPIResult.self, from: successData)
                        completion(true, Translate(trad: results.data.translations[0].translatedText))
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
