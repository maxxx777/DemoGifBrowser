//
//  Networking.swift
//  DemoGifBrowser
//
//  Created by MAXIM TSVETKOV on 14.07.18.
//  Copyright © 2018 MAXIM TSVETKOV. All rights reserved.
//

import Foundation

fileprivate typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

class Networking<T:Decodable> {
    
    private let provider: URLSession
    
    init(provider: URLSession = URLSession.shared) {
        
        self.provider = provider
    }
    
    func getItems(with urlString: String, completion: @escaping ([T], Error?) -> ()) {
        
        guard let url = URL(string: urlString) else { return }
        
        let task = provider.dataTask(with: url) { (data_, response_, error_) in
            
            guard let data = data_ else {
                completion([], error_)
                return
            }
            
            do {
                let items = try JSONDecoder().decode([T].self, from: data)
                completion(items, nil)
            } catch let parseError {
                completion([], parseError)
            }
            
        }
        
        task.resume()
    }
}
