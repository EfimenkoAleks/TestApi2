//
//  ExplorePhotoCellCollectionViewCell.swift
//  TestApi
//
//  Created by mac on 13.07.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class ExplorePhotoCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(_ photo: PhotoCollection) {
        if photo.photoImage != nil {
            imageView.image = photo.photoImage
        }
    }
    
}
