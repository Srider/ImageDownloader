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
private let TITLE = "title"
private let ORIGINAL_TITLE = "original_title"
private let LANGUAGE = "original_language"
private let BACKDROP_PATH = "backdrop_path"
private let POPULARITY = "popularity"
private let VOTE_COUNT = "vote_count"
private let VIDEO = "video"
private let VOTE_AVERAGE = "vote_average"
private let IMAGE = "dImageData"
private let GENRES = "genres"
private let RELEASE_DATE = "release_date"
private let OVERVIEW = "overview"
private let ADULT = "adult"
private let POSTER_PATH = "poster_path"
private let HOME_PAGE = "homepage"
private let TAG_LINE = "tagline"


class Movie: Mappable {
    var id:UInt64!
    var title:String!
    var original_title:String!
    var original_language:String!
    var backdrop_path:String!
    var popularity:Float!
    var vote_count:UInt64!
    var video:Bool!
    var vote_average:Float!
    var dImageData:Data?
    var genres:Array<String>!
    var release_date:String!
    var overview:String!
    var adult:Bool!
    var poster_path:String?
    var homepage:String?
    var tagline:String?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        id <- map[ID]
        title <- map[TITLE]
        original_title <- map[ORIGINAL_TITLE]
        original_language <- map[LANGUAGE]
        backdrop_path <- map[BACKDROP_PATH]
        popularity <- map[POPULARITY]
        vote_count <- map[VOTE_COUNT]
        video <- map[VIDEO]
        vote_average <- map[VOTE_AVERAGE]
        dImageData <- map[IMAGE]
        genres <- map[GENRES]
        release_date <- map[RELEASE_DATE]
        overview <- map[OVERVIEW]
        adult <- map[ADULT]
        poster_path <- map[POSTER_PATH]
        homepage <- map[HOME_PAGE]
        tagline <- map[TAG_LINE]
    }
    
}
