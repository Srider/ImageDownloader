//
//  File.swift
//  MoviesApp
//
//  Created by Srikar on 07/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class MoviesInteractor: PresenterToInteractorProtocol{
    var presenter: InteractorToPresenterProtocol?
    var objServerCommunication:ServerCommunication! = ServerCommunication.sharedInstance

    func fetchMoviesBasedOnSelection(_ selection:Int!, andPage pageNumber:Int!) {
        switch selection {
        case 0:
            discoverMovies(pageNumber)
        case 1:
            getNowPlayingMovies(pageNumber)
        case 2:
            getPopularMovies(pageNumber)
        case 3:
            getTopRatedMovies(pageNumber)
        default:
            print("Ivalid option")
        }
    }
    
    func discoverMovies(_ nPageNumber:Int!)->Swift.Void {
        let sDiscoverMoviesURL = Constants.URLS.k_DISCOVER_URL_PREFIX + Constants.ENDPOINTS.k_DISCOVER
    
        objServerCommunication.sendRequest(sDiscoverMoviesURL, subs: ["api_key=", "&language=en-US", "&sort_by=popularity.desc", "&include_adult=false", "&include_video=true", "&page=\(nPageNumber ?? 1)"], type:"GET", withResult:{
            (response:DataResponse<Any>?)->Swift.Void in
            print("*********************DISCOVER*********************")
            if let result = response!.result.value {
                let JSON = result as! NSDictionary
                let arrMovies:Array<Dictionary> = JSON.object(forKey: "results") as! Array<Dictionary<AnyHashable, Any>>
                let arrayObject = Mapper<Movie>().mapArray(JSONArray: arrMovies as! [[String : Any]]);
                
                self.presenter?.movieFetchSuccess(movieArray: self.fetchImagesForMovies(arrayObject))
            }else {
                self.presenter?.movieFetchFailed()
            }
        })
    }
    
    
    func getTopRatedMovies(_ nPageNumber:Int!)->Swift.Void {
        let sDiscoverMoviesURL = Constants.URLS.k_GENERIC_URL_PREFIX + Constants.ENDPOINTS.k_TOPRATED
        
        objServerCommunication.sendRequest(sDiscoverMoviesURL, subs: ["api_key=", "&language=en-US", "&page=\(nPageNumber ?? 1)"], type:"GET", withResult:{
            (response:DataResponse<Any>?)->Swift.Void in
            if let result = response!.result.value {
                print("*********************TopRated*********************")
                if let result = response!.result.value {
                    let JSON = result as! NSDictionary
                    let arrMovies:Array<Dictionary> = JSON.object(forKey: "results") as! Array<Dictionary<AnyHashable, Any>>
                    let arrayObject = Mapper<Movie>().mapArray(JSONArray: arrMovies as! [[String : Any]]);
                    self.presenter?.movieFetchSuccess(movieArray: self.fetchImagesForMovies(arrayObject))
                }else {
                    self.presenter?.movieFetchFailed()
                }
            }
        })
    }
    
    func getPopularMovies(_ nPageNumber:Int!)->Swift.Void {
        let sDiscoverMoviesURL = Constants.URLS.k_GENERIC_URL_PREFIX + Constants.ENDPOINTS.k_POPULAR
        
        objServerCommunication.sendRequest(sDiscoverMoviesURL, subs: ["api_key=", "&language=en-US", "&page=\(nPageNumber ?? 1)"], type:"GET", withResult:{
            (response:DataResponse<Any>?)->Swift.Void in
            if let result = response!.result.value {
                print("*********************Popular*********************")
                if let result = response!.result.value {
                    let JSON = result as! NSDictionary
                    let arrMovies:Array<Dictionary> = JSON.object(forKey: "results") as! Array<Dictionary<AnyHashable, Any>>
                    let arrayObject = Mapper<Movie>().mapArray(JSONArray: arrMovies as! [[String : Any]]);
                    self.presenter?.movieFetchSuccess(movieArray: self.fetchImagesForMovies(arrayObject))
                }else {
                    self.presenter?.movieFetchFailed()
                }
            }
        })
    }
    
    func getNowPlayingMovies(_ nPageNumber:Int!)->Swift.Void {
        let sDiscoverMoviesURL = Constants.URLS.k_GENERIC_URL_PREFIX + Constants.ENDPOINTS.k_NOW_PLAYING
        
        objServerCommunication.sendRequest(sDiscoverMoviesURL, subs: ["api_key=", "&language=en-US", "&page=\(nPageNumber ?? 1)"], type:"GET", withResult:{
            (response:DataResponse<Any>?)->Swift.Void in
            if let result = response!.result.value {
                print("*********************Now Playing*********************")
                if let result = response!.result.value {
                    let JSON = result as! NSDictionary
                    let arrMovies:Array<Dictionary> = JSON.object(forKey: "results") as! Array<Dictionary<AnyHashable, Any>>
                    let arrayObject = Mapper<Movie>().mapArray(JSONArray: arrMovies as! [[String : Any]]);
                    self.presenter?.movieFetchSuccess(movieArray: self.fetchImagesForMovies(arrayObject))
                }else {
                    self.presenter?.movieFetchFailed()
                }
            }
        })
    }
    
    
    func fetchImagesForMovies(_ arrMovies:Array<Movie>)->Array<Movie> {
        for objMovie in arrMovies {
            if objMovie.poster_path != nil {
                let url = URL(string: Constants.URLS.k_POSTER_URL_PREFIX + objMovie.poster_path!)
                self.downloadImageFromURL(url!, withResult: {
                    (data:Data!)->Swift.Void in
                    if data != nil {
                        objMovie.dImageData = data
                    } else {
                        objMovie.dImageData = nil
                    }
                })
            }
        }
        return arrMovies
    }
    
    func downloadImageFromURL(_ url: URL, withResult handler: @escaping(_ data:Data?)->Swift.Void) {
        let data = try? Data(contentsOf: url)
        handler(data)
    }
}
