//
//  ProfileImage.swift
//  MoviesApp
//
//  Created by Srikar on 17/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import UIKit
import ObjectMapper

private let SMALL = "small"
private let MEDIUM = "medium"
private let LARGE = "large"

class ProfileImage: Mappable {
    
    var small:String!
    var medium:String?
    var large:String?
   
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        small <- map[SMALL]
        medium <- map[MEDIUM]
        large <- map[LARGE]
    }
    
}
