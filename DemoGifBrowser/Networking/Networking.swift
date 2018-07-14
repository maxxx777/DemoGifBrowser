//
//  Networking.swift
//  DemoGifBrowser
//
//  Created by MAXIM TSVETKOV on 14.07.18.
//  Copyright © 2018 MAXIM TSVETKOV. All rights reserved.
//

import Foundation

class Networking<T:Codable> {
    
    private let provider: URLSession
    
    init(provider: URLSession = URLSession.shared) {
        
        self.provider = provider
    }
    
    func getItems(with urlString: String, completion: @escaping (SuccessResult<T>?, Error?) -> ()) {
        
        guard let url = URL(string: urlString) else { return }
        
        let task = provider.dataTask(with: url) { (data_, response_, error_) in
            
            guard let data = data_ else {
                completion(nil, error_)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(SuccessResult<T>.self, from: data)
                completion(response, nil)
            } catch let parseError {
                completion(nil, parseError)
            }
            
        }
        
        task.resume()
    }
}
