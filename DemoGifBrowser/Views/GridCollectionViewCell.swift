//
//  GridCollectionViewCell.swift
//  DemoGifBrowser
//
//  Created by MAXIM TSVETKOV on 14.07.18.
//  Copyright © 2018 MAXIM TSVETKOV. All rights reserved.
//

import UIKit
import FLAnimatedImage

class GridCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var previewImageView: FLAnimatedImageView?
    @IBOutlet weak var sizeLabel: UILabel?
    
    private let placeholderImage = UIImage(named: "placeholder")
    
    var viewModel: GridCellViewModel? {
        didSet {
            updatePreviewImage(with: viewModel?.previewImageURLString)
            updateSizeLabel(with: viewModel?.previewImageSizeString)
        }
    }
}

fileprivate extension GridCollectionViewCell {
    
    func updatePreviewImage(with urlString: String?) {
        
        guard let urlString_ = urlString else {
            previewImageView?.image = placeholderImage
            return
        }
        
        previewImageView?.downloadImage(from: urlString_, with: { [weak self] data in
            
            guard let data_ = data else {
                self?.previewImageView?.image = self?.placeholderImage
                return
            }
            
            self?.previewImageView?.animatedImage = FLAnimatedImage(gifData: data_)            
        })
    }
    
    func updateSizeLabel(with text: String?) {
        
        sizeLabel?.text = text
    }
}
