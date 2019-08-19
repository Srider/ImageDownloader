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
    
    func setMaxConcurrency(_ nMaxConcurrency:Int!) {
        NetworkManager.sharedServiceManager.setMaxConcurrency(nMaxConcurrency)
    }
    
    func addDownloadRequest( _ id:String!, fromURL strURL:String!,  withDelegate delegate:ImageDownloadDelegate ) -> Void {
        NetworkManager.sharedServiceManager.addRequestToQueue(id, fromURL:strURL, withDelegate:delegate)
    }
    
//    func setCacheDirectory(_ diskDirectory:String!) {
//        NetworkManager.sharedServiceManager.setCacheFolderName(diskDirectory)
//    }
}
