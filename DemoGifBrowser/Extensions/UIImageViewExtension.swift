//
//  UIImageViewExtension.swift
//  DemoGifBrowser
//
//  Created by MAXIM TSVETKOV on 14.07.18.
//  Copyright © 2018 MAXIM TSVETKOV. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloadImage(from urlString: String, with completion: @escaping (Data?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, _) -> Void in
            
            DispatchQueue.main.async {
                completion(data)
            }
            
        }).resume()
    }
    
}
