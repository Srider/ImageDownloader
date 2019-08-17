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

class ImagesInteractor: PresenterToInteractorProtocol{
    
    var presenter: InteractorToPresenterProtocol?
    var objServerCommunication:ServerCommunication! = ServerCommunication.sharedInstance

    func fetchImagesBasedOnSelection(_ selection: Int!, andPage pageNumber: Int!) {
        
        self.getImages("http://pastebin.com/raw/wgkJgazE")
    }
    
    func getImages(_ url:String!)->Swift.Void {
    
        objServerCommunication.sendRequest(url, type:"GET", withResult:{
            (response:DataResponse<Any>?)->Swift.Void in
            print("*********************DISCOVER*********************")
            if let result = response!.result.value {
                let JSON = result as! Array<Any>
                let arrImages:Array<Dictionary> = JSON as! Array<Dictionary<AnyHashable, Any>>
                let arrayObject = Mapper<Image>().mapArray(JSONArray: arrImages as! [[String : Any]]);
                
                self.presenter?.imageFetchSuccess(imageArray:arrayObject)
            }else {
                self.presenter?.imageFetchFailed()
            }
        })
    }
}
