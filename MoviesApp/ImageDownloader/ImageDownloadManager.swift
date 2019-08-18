//
//  ImageDownloader.swift
//  ImageDownloader
//
//  Created by Srikar on 17/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

class ImageDownloadManager {

    static let sharedDownloadManager = ImageDownloadManager()
    
    
    private init() {
        NetworkManager.sharedServiceManager.configureManager()
    }
    
    func addDownloadRequest( _ strURL:String!, onSuccess successBlock:@escaping (_ demoData:[String:Any]) -> Void, onFailure failureBlock: @escaping () -> ()) {
        
        NetworkManager.sharedServiceManager.addRequestToQueue(strURL, onSuccess: successBlock, onFailure:failureBlock)
    }
    
    func addDownloadRequest( _ strURL:String!, withDelegate delegate:ImageDownloadDelegate ) -> Void {
        NetworkManager.sharedServiceManager.addRequestToQueue(strURL, withDelegate:delegate)

    }

    
}
