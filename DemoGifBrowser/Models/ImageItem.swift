//
//  ImageItem.swift
//  DemoGifBrowser
//
//  Created by MAXIM TSVETKOV on 14.07.18.
//  Copyright © 2018 MAXIM TSVETKOV. All rights reserved.
//

import Foundation

struct ImageItem {
    
    let url: String
    let width: Int
    let height: Int
    
    init(url: String,
         width: Int,
         height: Int) {
        
        self.url = url
        self.width = width
        self.height = height
    }
    
    enum CodingKeys: String, CodingKey
    {
        case url
        case width
        case height
    }
}

extension ImageItem: Encodable {
    
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(url, forKey: .url)
        try container.encode(String(width), forKey: .width)
        try container.encode(String(height), forKey: .height)
    }
}

extension ImageItem: Decodable {
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let url = try values.decode(String.self, forKey: .url)
        let width = try values.decode(String.self, forKey: .width)
        let height = try values.decode(String.self, forKey: .height)
        
        self.init(url: url,
                  width: Int(width) ?? 0,
                  height: Int(height) ?? 0)
    }
}

extension ImageItem: Equatable {
    static func == (lhs: ImageItem, rhs: ImageItem) -> Bool {
        return lhs.url == rhs.url &&
            lhs.width == rhs.width &&
            lhs.height == rhs.height
    }
}
