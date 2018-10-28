//
//  ImageCollectionViewCell.swift
//  Flickr
//
//  Created by Arun Kumar on 28/10/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
