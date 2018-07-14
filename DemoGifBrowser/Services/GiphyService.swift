//
//  GiphyService.swift
//  DemoGifBrowser
//
//  Created by MAXIM TSVETKOV on 14.07.18.
//  Copyright © 2018 MAXIM TSVETKOV. All rights reserved.
//

import Foundation

typealias FetchGifItemsResult = ([GifItem], Error?) -> Void

protocol GiphyService {
    
    func fetchGifItems(with completion: @escaping FetchGifItemsResult)
}

class GiphyServiceImp: GiphyService {
    
    private let networking: Networking<[GifItem]>
    private let apiKey = "4GFiTKGP8ms0YK3UaL3OIowGIqMbsMEJ"
    
    init(networking: Networking<[GifItem]>) {
        self.networking = networking
    }
    
    func fetchGifItems(with completion: @escaping ([GifItem], Error?) -> Void) {
        
        let urlString = "https://api.giphy.com/v1/gifs/trending?api_key=" + apiKey
        
        networking.getItems(with: urlString, completion: { (successResult_, error_) in
            
            guard let successResult = successResult_ else {
                completion([], error_)
                return
            }
            
            completion(successResult.data, error_)
        })
        
    }
}
