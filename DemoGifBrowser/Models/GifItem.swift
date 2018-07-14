//
//  GifItem.swift
//  DemoGifBrowser
//
//  Created by MAXIM TSVETKOV on 14.07.18.
//  Copyright © 2018 MAXIM TSVETKOV. All rights reserved.
//

import Foundation

struct GifItem: Codable {
    
    let itemId: String
    let imagesItem: ImagesItem
    
    enum CodingKeys: String, CodingKey
    {
        case itemId = "id"
        case imagesItem = "images"
    }
}

extension GifItem: Equatable {
    static func == (lhs: GifItem, rhs: GifItem) -> Bool {
        return lhs.itemId == rhs.itemId &&
            lhs.imagesItem == rhs.imagesItem
    }
}
