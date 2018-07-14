//
//  GridViewModel.swift
//  DemoGifBrowser
//
//  Created by MAXIM TSVETKOV on 14.07.18.
//  Copyright © 2018 MAXIM TSVETKOV. All rights reserved.
//

import Foundation

protocol GridViewModel {
    
    func fetchItems(with completion: @escaping (Error?) -> Void)
    func numberOfItems() -> Int
    func cellViewModel(at index: Int) -> GridCellViewModel?
}

class GridViewModelImp: GridViewModel {
    
    private let giphyService: GiphyService
    private var dataSource: [GridCellViewModel]?
    
    init(giphyService: GiphyService) {
        
        self.giphyService = giphyService
    }
    
    func fetchItems(with completion: @escaping (Error?) -> Void) {
        
        giphyService.fetchGifItems { [weak self] (gifItems, error) in
            
            guard let _ = error else {
                
                self?.dataSource = gifItems.map {
                    GridCellViewModel(item: $0)
                }
                
                DispatchQueue.main.async {
                    completion(nil)
                }
                
                return
            }
            
            DispatchQueue.main.async {
                completion(error)
            }
        }
    }
    
    func numberOfItems() -> Int {
        
        return dataSource?.count ?? 0
    }
    
    func cellViewModel(at index: Int) -> GridCellViewModel? {
        
        guard let cellViewModels = dataSource else { return nil }
        
        guard cellViewModels.count > index else { return nil }
        
        return cellViewModels[index]
    }
}
