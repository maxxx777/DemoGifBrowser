//
//  AppCoordinator.swift
//  DemoGifBrowser
//
//  Created by MAXIM TSVETKOV on 14.07.18.
//  Copyright © 2018 MAXIM TSVETKOV. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    private let navigationController = UINavigationController()
    private let factory = AppFactory()
    
    init(window: UIWindow?) {
        
        window?.rootViewController = navigationController
    }
    
    func start() {
        
        let viewController = factory.gridViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
