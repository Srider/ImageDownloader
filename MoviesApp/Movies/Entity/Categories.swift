//
//  Categories.swift
//  MoviesApp
//
//  Created by Srikar on 17/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import UIKit
import ObjectMapper

private let ID = "id"
private let TITLE = "title"
private let PHOTO_COUNT = "photo_count"
private let LINKS = "links"

class Categories: Mappable {
    var id:UInt64!
    var title:String!
    var photo_count:UInt64!
    var links:Links!
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        id <- map[ID]
        title <- map[TITLE]
        photo_count <- map[PHOTO_COUNT]
        links <- map[LINKS]
    }
}
