//
//  DataServisForControls.swift
//  TestApi
//
//  Created by mac on 17.07.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import Alamofire

class DataServisForControls {
    
    static let instanceControl = DataServisForControls()
    var photoCollection = [Photo]()
    
    var imageCache = NSCache<NSString, UIImage>()
    var choisePhotos = [ChoicePhoto]()
    
    func downloadTopPhotoCollection(completed: @escaping DownloadComplete) {
        // https://api.unsplash.com/search/collections?page=1&query=office
        
        var titlString, imageUrlString, imageBig : String!
        var description: String = ""
        var imageWidth , imageHeight: CGFloat!
        let page = String(LOAD_PAGE)
        let url = SEARCH_PHOTO_CONST + page + SEARCH_PER_PAGE + QUERY + CLIENT_ID
        
        request(url).responseJSON { (response) in
            //           print(response)
            switch response.result {
                
            case .success(let value):
                isResponse = true
                
                if let array = value as? [String : Any] {
                    
                    if let arrayRezult = array["results"] as? [[String: Any]], arrayRezult.count > 0 {
                        for i in 0..<arrayRezult.count {
                            if let photoTitl = arrayRezult[i]["title"] as? String {
                                titlString = photoTitl
                            }
                            if let photoDict = arrayRezult[i]["cover_photo"] as? [String : Any] {
                                if let height = photoDict["height"] as? CGFloat {
                                    imageHeight = height
                                }
                                if let width = photoDict["width"] as? CGFloat {
                                    imageWidth = width
                                }
                                if let photoUrl = photoDict["urls"] as? [String : Any] {
                                    if let imageUrl = photoUrl["small"] as? String {
                                        imageUrlString = imageUrl
                                    }
                                    if let imageUrl2 = photoUrl["full"] as? String {
                                        imageBig = imageUrl2
                                    }
                                }
                                if let descript = photoDict["description"] as? String {
                                    description = descript
                                }
                                if description.count > 1 {
                                    titlString = description
                                }
                            }
                            
                            let photoCollect = Photo(titl: titlString, imageUrl: imageUrlString, photoBig: imageBig, photoHeight: imageHeight, photoWidth: imageWidth)
                            self.photoCollection.append(photoCollect)
                            
                            description = ""
                        }
                        for photo in self.photoCollection {
                            photo.downloadPhotoImage(completed: {
                                
                            })
                        }
                    }
                }
                completed()
            case .failure(let error):
                isResponse = false
                print("\(error)")
            }
            
            
        }
    }
    
    func downloadImageBig(url: String, completion: @escaping (UIImage?) -> Void) {
        
        if let cachedImage = self.imageCache.object(forKey: url as NSString) {
            completion(cachedImage)
        } else {
            
            request(url).responseData { (response) in
                if let data = response.result.value {
                    if let images = UIImage(data: data) {
                        
                        self.imageCache.setObject(images, forKey: url as NSString)
                        
                        DispatchQueue.main.async {
                            completion(images)
                        }
                    }
                }
                
            }
        }
    }
    
    
}

