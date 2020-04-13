//
//  Constants.swift
//  TestApi
//
//  Created by mac on 15.07.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import UIKit

//Unsplash API URL

let SEARCH_PHOTO_CONST = "https://api.unsplash.com/search/collections?page="
var LOAD_PAGE = 1
let SEARCH_PER_PAGE = "&per_page=20&query="

var QUERY = ""

let CLIENT_ID = "&client_id=dc604035161fce51f0053b2f69c0ca60b207e1b354e90d1100cadb7141f3a28e"

let NAME_COLLECTION = ["Summer + Tropical","Black & White","WORK","Women Are Amazing","Water Drop","Adventure","ROAD","Beautiful","Yellow","music","Dark Portraits","Flowers Contained","Backgrounds / Textures","Pyro","WORK","Animals"]

typealias DownloadComplete = () -> ()

var isResponse = true

var isLoading = true // чтоб не загружать одно и тоже

var gIndexForCollection = 1 // индекс для запоминания положения выбранной item
var gWillDisplay = false
