//
//  AppFactory.swift
//  DemoGifBrowser
//
//  Created by MAXIM TSVETKOV on 14.07.18.
//  Copyright © 2018 MAXIM TSVETKOV. All rights reserved.
//

import UIKit

class AppFactory {
    
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func gridViewController() -> GridViewController {
        
        let giphyService = GiphyServiceImp()
        let viewModel = GridViewModelImp(giphyService: giphyService)
        let viewController = storyboard.instantiateViewController(withIdentifier: "GridViewController") as! GridViewController
        
        viewController.viewModel = viewModel
        
        return viewController
    }
}
