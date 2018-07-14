//
//  GridCellViewModel.swift
//  DemoGifBrowser
//
//  Created by MAXIM TSVETKOV on 14.07.18.
//  Copyright © 2018 MAXIM TSVETKOV. All rights reserved.
//

import Foundation

struct GridCellViewModel {
    
    private var item: GifItem
    private var previewImageItem: ImageItem {
        return item.imagesItem.preview
    }
    
    init(item: GifItem) {
        self.item = item
    }
    
    var previewImageURLString: String {
        return previewImageItem.url
    }
    
    var previewImageSizeString: String {
        return "\(previewImageItem.width)x\(previewImageItem.height)"
    }
}
