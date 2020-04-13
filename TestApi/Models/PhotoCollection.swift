//
//  PhotoCollection.swift
//  TestApi
//
//  Created by mac on 17.07.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Alamofire

class Photo {
    
    var photoTitl: String!
    var photoImageUrl: String!
    var photoImage: UIImage?
    var photoImageUrlBig: String!
    var photoHeight: CGFloat!
    var photoWidth: CGFloat!
    var photoCoefHeight: CGFloat?
    
    init(titl: String , imageUrl: String , photoBig: String, photoHeight: CGFloat, photoWidth: CGFloat) {
        self.photoTitl = titl
        self.photoImageUrl = imageUrl
        self.photoImageUrlBig = photoBig
        self.photoHeight = photoHeight
        self.photoWidth = photoWidth
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
    
//        func downloadPhotoImage(completion: @escaping (UIImage?) -> Void) {
//            request(self.photoImageUrl).responseData { (response) in
//                if let data = response.result.value {
//                    if let images = UIImage(data: data) {
//                        self.photoImage = images
//
//                        DispatchQueue.main.async {
//                            completion(images)
//                        }
//                    }
//                }
//
//            }
//
//        }

    
    
}
