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
    var photoCollection = [PhotoCollection]()
    
    func downloadTopPhotoCollection(completed: @escaping DownloadComplete) {
        
        var titlString, imageUrlString, imageBig : String!
        let page = String(LOAD_PAGE)
        let url = SEARCH_PHOTO_CONST + page + SEARCH_PER_PAGE + QUERY + CLIENT_ID
        
        request(url).responseJSON { (response) in
            print(response)
            
            if let array = response.result.value as? [String : Any] {
                
                if let arrayRezult = array["results"] as? [[String: Any]], arrayRezult.count > 0 {
                    for i in 0..<arrayRezult.count {
                        if let photoTitl = arrayRezult[i]["title"] as? String {
                            titlString = photoTitl
                        }
                        if let photoDict = arrayRezult[i]["cover_photo"] as? [String : Any] {
                            if let photoUrl = photoDict["urls"] as? [String : Any] {
                                if let imageUrl = photoUrl["thumb"] as? String {
                                    imageUrlString = imageUrl
                                }
                                if let imageUrl2 = photoUrl["full"] as? String {
                                    imageBig = imageUrl2
                                }
                            }
                        }
                        let photoCollect = PhotoCollection(titl: titlString, imageUrl: imageUrlString, photoBig: imageBig)
                        self.photoCollection.append(photoCollect)
                    }
                }
            }
            
            completed()
        }
    }
}

