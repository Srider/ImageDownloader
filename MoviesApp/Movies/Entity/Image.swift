//
//  Movie.swift
//  MovieApp
//
//  Created by Srikar on 29/07/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import UIKit
import ObjectMapper

private let ID = "id"
private let CREATED_AT = "created_at"
private let WIDTH = "width"
private let HEIGHT = "height"
private let COLOR = "color"
private let LIKES = "likes"
private let LIKED_BY_USER = "liked_by_user"
private let USER = "user"
private let COLLECTIONS = "current_user_collections"
private let URL_STRINGS = "urls"
private let CATEGORIES = "categories"
private let LINKS = "links"


class Image: Mappable {
    var id:String!
    var created_at:String!
    var width:String!
    var height:String!
    var color:String!
    var likes:Float!
    var liked_by_user:UInt64!
    var user:User!
    var current_user_collections:Data?
    var urls:Array<String>!
    var categories:String!
    var links:Links!

    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        id <- map[ID]
        created_at <- map[CREATED_AT]
        width <- map[WIDTH]
        height <- map[HEIGHT]
        color <- map[COLOR]
        likes <- map[LIKES]
        liked_by_user <- map[LIKED_BY_USER]
        user <- map[USER]
        links <- map[LINKS]
        current_user_collections <- map[COLLECTIONS]
        urls <- map[URL_STRINGS]
        categories <- map[CATEGORIES]
    }
    
}
