//
//  DataServis.swift
//  TestApi
//
//  Created by mac on 15.07.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import Alamofire

class DataServis {
    static let instance = DataServis()
    
    var photo = [Photo]()
    
    func downloadTopPhoto(completed: @escaping DownloadComplete) {
        var nameString, imageUrlString : String!
      //  var likesString : Int
        let url = NewPhoto
        
        request(url).responseJSON { (response) in
            print(response)
            
            if let array = response.result.value as? [[String : Any]], array.count > 0 {
                
                    for i in 0..<array.count {
                        if let photoId = array[i]["id"] as? String {
                            nameString = photoId
                        }
//                        if let photoLike = array[i]["likes"] as? String {
//                           // likesString = Int.(photoLike)
//                            likesString = photoLike.to
//
//
//                        }
                        if let photoDict = array[i]["urls"] as? [String : Any] {
                            if let imageUrl = photoDict["small"] as? String {
                                imageUrlString = imageUrl
                            }
                        }
                        let photo = Photo(name: nameString, imageUrl: imageUrlString)
                        self.photo.append(photo)
                    }
             }
            
            completed()
        }
    }
}
