//
//  ImageDownloader.swift
//  ImageDownloader
//
//  Created by Srikar on 17/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

class ImageDownloadManager {

    static let sharedDownloadManager = ImageDownloadManager()
    fileprivate var nRequestCount:UInt64!
    
    private init() {
        nRequestCount = 0
        NetworkManager.sharedServiceManager.configureManager()
    }
    
    func addDownloadRequest( _ strURL:String!, onSuccess successBlock:@escaping (_ demoData:[String:Any]) -> Void, onFailure failureBlock: @escaping () -> ()) {
        let objDownloadDetail = DownloadDetail.init(nRequestCount, withURL: strURL, onSuccess: successBlock , onFailure : failureBlock)
        NetworkManager.sharedServiceManager.addRequestToQueue(objDownloadDetail)
    }
    
}
