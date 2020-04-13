//
//  MenuCell.swift
//  TestApi
//
//  Created by mac on 7/30/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        // lb.font = UIFont.systemFont(ofSize: 22)
        lb.font = UIFont(name: "AvenirNext-Medium", size: 22)
        lb.backgroundColor = .clear
        //        lb.shadowColor = .purple
        //        let size = CGSize(width: 0, height: -1)
        //        lb.shadowOffset = size
        //    lb.layer.cornerRadius = 10
        //     lb.layer.masksToBounds = true
        //      lb.lineBreakMode = .byWordWrapping
        //     lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let imageLabel: UIImageView = {
        let imageView1 = UIImageView()
        imageView1.image = UIImage(named: "connect")
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(nameLabel)
        addSubview(imageLabel)
        
        imageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        imageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        imageLabel.widthAnchor.constraint(equalToConstant: 17).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: imageLabel.trailingAnchor, constant: 16).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.size.height -= 2 * 2
            super.frame = frame
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.selectionStyle = .none
        self.layer.cornerRadius = 10.0
        self.backgroundColor = .clear // #colorLiteral(red: 0.5588633058, green: 0.7812896777, blue: 0.9915801883, alpha: 1)
        
    }
    
}

