//
//  ImagesItem.swift
//  DemoGifBrowser
//
//  Created by MAXIM TSVETKOV on 14.07.18.
//  Copyright © 2018 MAXIM TSVETKOV. All rights reserved.
//

import Foundation

struct ImagesItem: Codable {
    
    let original: ImageItem
    let preview: ImageItem
    
    enum CodingKeys: String, CodingKey
    {
        case original
        case preview = "preview_gif"
    }
}

extension ImagesItem: Equatable {
    static func == (lhs: ImagesItem, rhs: ImagesItem) -> Bool {
        return lhs.original == rhs.original &&
            lhs.preview == rhs.preview
    }
}
