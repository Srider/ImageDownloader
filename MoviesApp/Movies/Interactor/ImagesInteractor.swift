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
import DownloadManager

class ImagesInteractor: PresenterToInteractorProtocol {
    
    var arrImagesList:Array<Image>?
    var objImageDownloader:DownloadManager! = DownloadManager.sharedDownloadManager
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
                self.arrImagesList = Mapper<Image>().mapArray(JSONArray: arrImages as! [[String : Any]]);
                self.presenter?.imageFetchSuccess(imageArray:self.arrImagesList!)
            }else {
                self.presenter?.imageFetchFailed()
            }
        })
    }
    
    
    func fetchImagesForItems(_ arrImagesList: Array<Image>) {
        objImageDownloader.cancelAllDownloads(self)
        self.arrImagesList = arrImagesList
        if self.arrImagesList!.count > 0 {
            for tempImageItem in self.arrImagesList! {
                let objImageItem:Image = tempImageItem as Image
                if objImageItem.bImageFetchCompleted != true {
                    print("Adding - \(objImageItem.urls.raw)")
                    objImageDownloader.addDownloadRequest(objImageItem.id, fromURL: objImageItem.urls.raw, withDelegate:self)
                }
            }
        }
    }
}

extension ImagesInteractor: DownloadDelegate {
    
    func didFinishDownloadWithStatus(_ status:Bool, andData data:[String:Any]) {
        print("didFinishImageDownloadWithStatus - \(data)")
        
        let dItemID = data["id"] as! String
        let dImageData = data["data"] as? Data
        
        for tempImageItem in self.arrImagesList! {
            let objImageItem:Image = tempImageItem as Image
            if objImageItem.id == dItemID {
                if dImageData != nil {
                    objImageItem.dImageData = data["data"] as? Data
                } else {
                    objImageItem.dImageData = nil
                }
                objImageItem.bImageFetchCompleted = true
            }
        }
        self.presenter?.refreshImageItems(imageArray:self.arrImagesList!)
    }
    
    func didCancelDownloadWithStatus(_ status: Bool, andData data: [String : Any]) {
        print("didCancelDownloadWithStatus - \(data)")
        let dItemID = data["id"] as! String
        
        for tempImageItem in self.arrImagesList! {
            let objImageItem:Image = tempImageItem as Image
            if objImageItem.id == dItemID {
                objImageItem.dImageData = nil
                objImageItem.bImageFetchCompleted = true
            }
        }
        self.presenter?.refreshImageItems(imageArray:self.arrImagesList!)
    }
    
    func didCancelAllDownloads(_ status: Bool) {
        self.presenter?.refreshImageItems(imageArray:self.arrImagesList!)
    }
}
