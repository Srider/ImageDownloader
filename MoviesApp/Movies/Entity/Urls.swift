//
//  User.swift
//  MoviesApp
//
//  Created by Srikar on 17/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import UIKit
import ObjectMapper

private let RAW = "raw"
private let FULL = "full"
private let SMALL = "small"
private let THUMB = "thumb"


class Urls: Mappable {
    var raw:String!
    var full:String!
    var small:String!
    var thumb:String!
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        raw <- map[RAW]
        full <- map[FULL]
        small <- map[SMALL]
        thumb <- map[THUMB]
    }
    
    
}
