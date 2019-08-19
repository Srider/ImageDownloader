//
//  NetworkManager.swift
//  Countries
//
//  Created by Honeywell on 11/11/17.
//  Copyright © 2017 Honeywell. All rights reserved.
//

import UIKit

let kDEFAULT_CONCURRENCY:Int = 3

protocol CacheServiceDelegate {
    func setCacheFolderName(_ strFolderName:String!)
    func getImageFromCache(_ url:String!)->DownloadDetail?
    func addImageDataToCache(_ downloadDetail:DownloadDetail)
}


protocol EventNotificationsDelegate {
    func registerNotifications()
    func unregisterNotifications()
    func didUpdateResultsWithData(_ notification:Notification)->Void
    func didEndRequestWithFailure(_ notification:Notification)->Void
}

protocol ServiceQueueDelegate {
    func setMaxConcurrency(_ nMaxConcurrency:Int!) -> Void
    func addRequestToQueue(_ id: String!, fromURL strURL:String!, withDelegate delegate:ImageDownloadDelegate)
    func sendRequest()
    func updateOperationStatus(_ objDownloadDetail:DownloadDetail!)
    func refreshQueue()
}

class NetworkManager: NSObject {
    var timer:Timer!
    var arrRequestList:NSMutableArray = NSMutableArray.init()
    var requestQueue:GlobalServiceQueue? = GlobalServiceQueue.sharedQueue
    var objCacheManager:CacheService! = CacheService.sharedManager

    static let sharedServiceManager = NetworkManager()

    //Configure Request Queue and Start Timer
    func configureManager() -> Void {
        
        /* Register for notifications */
        registerNotifications()
        
        /* Make serial. */
        requestQueue?.maxConcurrentOperationCount = kDEFAULT_CONCURRENCY
            
        /* Start Timer */
        startTimer()
        
    }
    
    //Start Timer
    func startTimer() {
        if timer == nil {
            /*start timer for periodic scheduling of requests */
            timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (Timer)->() in
                self.refreshQueue()
            })
        }
    }
    
    //Stop Timer
    func stopTimer() {
        if timer != nil {
            timer.invalidate()
        }
    }
   
    deinit {
        stopTimer()
        unregisterNotifications()
    }
}


extension NetworkManager: EventNotificationsDelegate {
    
    //MARK: Register Notifications
    func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateResultsWithData), name: NSNotification.Name(rawValue: Constants.Notifications.kNetworkOperationSuccess), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didEndRequestWithFailure), name: NSNotification.Name(rawValue: Constants.Notifications.kNetworkOperationFailure), object: nil)
    }
    
    //MARK: Unregister Notificatons
    func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: didUpdateSearchResults()
    @objc func didUpdateResultsWithData(_ notification:Notification)->Void {
        let dictResults = notification.object! as! NSMutableDictionary
        let objDownloadDetail = dictResults.object(forKey: "download_detail") as! DownloadDetail
        updateOperationStatus(objDownloadDetail)
    }
    
    //MARK: didFailToSendRequest()
    @objc func didEndRequestWithFailure(_ notification:Notification)->Void {
        let dictResults = notification.object! as! NSMutableDictionary
        let objDownloadDetail = dictResults.object(forKey: "download_detail") as! DownloadDetail
        updateOperationStatus(objDownloadDetail)
    }
}




extension NetworkManager: ServiceQueueDelegate {
    
    func setMaxConcurrency(_ nMaxConcurrency:Int!) -> Void {
        /* Make serial. */
        self.requestQueue?.maxConcurrentOperationCount = nMaxConcurrency
    }
    
    public func addRequestToQueue(_ id: String!, fromURL strURL:String!, withDelegate delegate:ImageDownloadDelegate  ) {
        let objDownloadDetail = DownloadDetail.init(id, withURL: strURL, andDelegate: delegate)
        
        /* Add request operation to Queue. */
        self.arrRequestList.add(objDownloadDetail)
        self.sendRequest()
    }
    
    // MARK: - Periodic Send Request
    internal func sendRequest() {
        for tempDownloadDetail in self.arrRequestList {
            let objDownloadDetail = tempDownloadDetail as! DownloadDetail
            let imgDownloadDetail = self.getImageFromCache(objDownloadDetail.strDownloadURL)
            if imgDownloadDetail != nil {
                var dictResults:[String:Any] = [:]
                dictResults["data"] = imgDownloadDetail!.dImageData
                dictResults["url"] = imgDownloadDetail!.strDownloadLocation
                dictResults["id"] = imgDownloadDetail!.id
                
                DispatchQueue.main.async {
                    objDownloadDetail.cDelegate?.didFinishImageDownloadWithStatus(true, andData:dictResults)
                }
                self.arrRequestList.remove(tempDownloadDetail)
            } else {
                if objDownloadDetail.eDownloadStatus == DownloadStatus.none {
                    objDownloadDetail.eDownloadStatus = DownloadStatus.started
                    let imgDownloadService = ImageDownloadService.init(objDownloadDetail)
                    print("Adding Request - \(objDownloadDetail.id)")
                    self.requestQueue?.addOperation {
                        imgDownloadService.main()
                    }
                }
            }
        }
    }
    
    //MARK: removeCompletedOperation()
    func updateOperationStatus(_ objDownloadDetail:DownloadDetail!) {
        for tempDownloadDetail in self.arrRequestList {
            let downloadDetail = tempDownloadDetail as! DownloadDetail
            if downloadDetail.id == objDownloadDetail.id {
                downloadDetail.eDownloadStatus = objDownloadDetail.eDownloadStatus
                print("Updating Status - \(String(describing: downloadDetail.eDownloadStatus))")
            }
        }
    }
    
    func refreshQueue() {
        if (self.arrRequestList.count > 0) {
            let eRequestList = self.arrRequestList.mutableCopy() as! NSMutableArray
            for tempDownloadDetail in eRequestList {
                let downloadDetail = tempDownloadDetail as! DownloadDetail
                if downloadDetail.eDownloadStatus == DownloadStatus.downloaded {
                    print("Deleting Completed Request - \(String(describing: downloadDetail.id)) with status: \(downloadDetail.eDownloadStatus)")
                    
                    var dictResults:[String:Any] = [:]
                    
                    dictResults["data"] = downloadDetail.dImageData
                    dictResults["url"] = downloadDetail.strDownloadLocation
                    dictResults["id"] = downloadDetail.id
                    
                    self.addImageDataToCache(downloadDetail)
                    
                    DispatchQueue.main.async {
                        downloadDetail.cDelegate?.didFinishImageDownloadWithStatus(true, andData:dictResults)
                    }
                    self.arrRequestList.remove(tempDownloadDetail)
                } else if downloadDetail.eDownloadStatus == DownloadStatus.failed {
                    print("Deleting Completed Request - \(String(describing: downloadDetail.id)) with status: \(downloadDetail.eDownloadStatus)")
                    var dictResults:[String:Any] = [:]
                    dictResults["id"] = downloadDetail.id
                    DispatchQueue.main.async {
                        downloadDetail.cDelegate?.didFinishImageDownloadWithStatus(false, andData: dictResults)
                    }
                
                    self.arrRequestList.remove(tempDownloadDetail)
                }
            }
        }
    }
}


extension NetworkManager: CacheServiceDelegate {
    
    func setCacheFolderName(_ strFolderName:String!) {
        self.objCacheManager?.setCacheFolderName(strFolderName)
    }
    
    func getImageFromCache(_ url:String!)->DownloadDetail? {
        let data = self.objCacheManager!.fromMemory(url)
        return data
    }
    
    func addImageDataToCache(_ downloadDetail:DownloadDetail) {
        if downloadDetail.dImageData != nil && downloadDetail.eDownloadStatus == DownloadStatus.downloaded {
            self.objCacheManager!.add(downloadDetail)
        }
    }
}

