//
//  GridViewModel.swift
//  DemoGifBrowser
//
//  Created by MAXIM TSVETKOV on 14.07.18.
//  Copyright © 2018 MAXIM TSVETKOV. All rights reserved.
//

import Foundation

protocol GridViewModel {
    
    func fetchItems()
}

class GridViewModelImp: GridViewModel {
    
    private let giphyService: GiphyService
    
    init(giphyService: GiphyService) {
        
        self.giphyService = giphyService
    }
    
    func fetchItems() {
        
    }
}
