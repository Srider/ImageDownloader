//
//  Urls.swift
//  MoviesApp
//
//  Created by Srikar on 17/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import UIKit
import ObjectMapper

private let ID = "id"
private let USER_NAME = "username"
private let NAME = "name"
private let PROFILE_IMAGE = "profile_image"
private let LINKS = "links"

class User: Mappable {

    var id:String!
    var username:String?
    var name:String?
    var profile_image:ProfileImage?
    var links:Links?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        id <- map[ID]
        username <- map[USER_NAME]
        name <- map[NAME]
        profile_image <- map[PROFILE_IMAGE]
        links <- map[LINKS]
    }
}
