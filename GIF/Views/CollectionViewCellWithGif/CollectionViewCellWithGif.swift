//
//  CollectionViewCellWithGif.swift
//  GIF
//
//  Created by admin on 28.05.2021.
//

import UIKit
import SwiftyGif

class CollectionViewCellWithGif: UICollectionViewCell {
    
    // MARK: - Static
    static let identifier: String = "CollectionViewCellWithGif"
    
    // MARK: - IBOutlets
    @IBOutlet weak var gifImageView: UIImageView!
    
    // MARK: - Actions
    func runGif(with url: URL) {
        gifImageView.clear()
        gifImageView.setGifFromURL(url)
    }
}
