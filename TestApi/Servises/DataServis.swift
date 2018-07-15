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
        let url = NewPhoto
        request(url).responseJSON { (response) in
            print(response)
        }
    }
}
