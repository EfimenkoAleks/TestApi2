//
//  PhotoCollection.swift
//  TestApi
//
//  Created by mac on 17.07.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Alamofire

class PhotoCollection {
    
    var photoTitl: String!
    var photoImageUrl: String!
    var photoImage: UIImage?
    var photoImageUrlBig: String!
    
    init(titl: String , imageUrl: String , photoBig: String) {
        self.photoTitl = titl
        self.photoImageUrl = imageUrl
        self.photoImageUrlBig = photoBig
    }
    
    func downloadPhotoImage(completed: @escaping DownloadComplete) {
        request(self.photoImageUrl).responseData { (response) in
            if let data = response.result.value {
                if let images = UIImage(data: data) {
                    self.photoImage = images
                }
            }
            completed()
        }
        
    }
    
   
    
    
}
