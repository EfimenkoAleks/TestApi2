//
//  PhotoCell.swift
//  TestApi
//
//  Created by user on 7/31/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    
    
    var imageView: UIImageView = {
        let imageView1 = UIImageView()
        imageView1.image = UIImage(named: "picture")
        //  let imageTemp = imageView1.image?.withRenderingMode(.alwaysTemplate)
        //  imageView1.image = imageTemp
        // imageView1.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        //     imageView1.layer.cornerRadius = 16
        imageView1.layer.masksToBounds = true
        imageView1.contentMode = .scaleAspectFill
        imageView1.backgroundColor = .clear
        //    imageView1.layer.borderWidth = 1
        return imageView1
    }()
    
    //    var label: UILabel = {
    //        let lb = UILabel()
    //        lb.textAlignment = .left
    //        lb.font = UIFont.systemFont(ofSize: 17)
    //        // lb.font = UIFont(name: "HelveticaNeue-BoldItalic", size: 30)
    //        lb.backgroundColor = .clear
    //        //        lb.shadowColor = .purple
    //        //        let size = CGSize(width: 0, height: -1)
    //        //        lb.shadowOffset = size
    //        lb.layer.cornerRadius = 10
    //        lb.layer.masksToBounds = true
    //        //      lb.lineBreakMode = .byWordWrapping
    //        lb.numberOfLines = 0
    //        lb.translatesAutoresizingMaskIntoConstraints = false
    //        return lb
    //    }()
    
    //    let bubbleView: UIView = {
    //        let view = UIView()
    //        view.backgroundColor = .clear
    //        view.layer.cornerRadius = 6
    //        view.layer.masksToBounds = true
    //        view.translatesAutoresizingMaskIntoConstraints = false
    //        return view
    //    }()
    
    var bottomImage: NSLayoutConstraint?
    var heightImage: CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ photo: UIImage?) {
        if photo != nil {
            imageView.image = photo
            
        }
    }
    
}
