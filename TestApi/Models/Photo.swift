//
//  Photo.swift
//  TestApi
//
//  Created by mac on 15.07.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Alamofire

class Photo {
    var photoName: String
    var photoImageUrl: String
    var photoImage: UIImage
    
    init(name: String , imageUrl: String , image: UIImage) {
        self.photoName = name
        self.photoImageUrl = imageUrl
        self.photoImage = image
    }
    
    func downloadPhotoImage(completed: @escaping DownloadComplete) {
        request(self.photoImageUrl).responseData { (response) in
            if let data = response.result.value {
                if let image = UIImage(data: data) {
                    self.photoImage = image
                }
            }
            completed()
        }
    }
    
}
