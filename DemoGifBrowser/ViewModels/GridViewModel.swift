//
//  GridViewModel.swift
//  DemoGifBrowser
//
//  Created by MAXIM TSVETKOV on 14.07.18.
//  Copyright © 2018 MAXIM TSVETKOV. All rights reserved.
//

import Foundation

protocol GridViewModel {
    
    func fetchItems(with completion: @escaping ([GridCollectionViewModel], Error?) -> Void)
}

class GridViewModelImp: GridViewModel {
    
    private let giphyService: GiphyService
    
    init(giphyService: GiphyService) {
        
        self.giphyService = giphyService
    }
    
    func fetchItems(with completion: @escaping ([GridCollectionViewModel], Error?) -> Void) {
        
        giphyService.fetchGifItems { (gifItems, error) in
            
            guard let _ = error else {
                
                let cellViewModels = gifItems.map {
                    GridCollectionViewModel(item: $0)
                }
                
                DispatchQueue.main.async {
                    completion(cellViewModels, nil)
                }
                
                return
            }
            
            DispatchQueue.main.async {
                completion([], error)
            }
        }
    }
}
