//
//  Links.swift
//  MoviesApp
//
//  Created by Srikar on 17/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import UIKit

import ObjectMapper

private let SELF_LINK = "self"
private let HTML = "html"
private let DOWNLOAD = "download"
private let LIKES = "likes"
private let PHOTOS = "photos"


class Links: Mappable {
    var self_link:String!
    var html:String?
    var download:String?
    var likes:String?
    var photos:String?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        self_link <- map[SELF_LINK]
        html <- map[HTML]
        download <- map[DOWNLOAD]
        likes <- map[LIKES]
        photos <- map[PHOTOS]
    }
    
}
