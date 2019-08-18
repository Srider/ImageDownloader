//
//  NetworkManager.swift
//  Countries
//
//  Created by Honeywell on 11/11/17.
//  Copyright © 2017 Honeywell. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    static let sharedServiceManager = NetworkManager()
    var arrRequestList:NSMutableArray = NSMutableArray.init()
    var requestQueue:GlobalServiceQueue? = GlobalServiceQueue.sharedQueue
    var timer:Timer!
    var nRequestCount:UInt64!
    
    //Configure Request Queue and Start Timer
    func configureManager() -> Void {
        
        nRequestCount = 0

        /* Register for notifications */
        registerNotifications()
        
        /* Make serial. */
        requestQueue?.maxConcurrentOperationCount = 5
        
        /* Start Timer */
        startTimer()
        
    }
    
    //MARK: Register Notifications
    func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateResultsWithData), name: NSNotification.Name(rawValue: Constants.Notifications.kNetworkOperationSuccess), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didEndRequestWithFailure), name: NSNotification.Name(rawValue: Constants.Notifications.kNetworkOperationFailure), object: nil)
    }
    
    //MARK: Unregister Notificatons
    func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self)
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

    
    public func addRequestToQueue( _ strURL:String!, onSuccess successBlock:@escaping (_ demoData:[String:Any]) -> Void, onFailure failureBlock: @escaping () -> ()) {
        
        nRequestCount = nRequestCount+1
        
        let objDownloadDetail = DownloadDetail.init(nRequestCount, withURL: strURL, onSuccess: successBlock , onFailure : failureBlock)
        
        /* Add request operation to Queue. */
        arrRequestList.add(objDownloadDetail)
        self.sendRequest()
    }
    
    public func addRequestToQueue(_ strURL:String!, withDelegate delegate:ImageDownloadDelegate  ) {
        
        nRequestCount = nRequestCount+1
        
        let objDownloadDetail = DownloadDetail.init(nRequestCount, withURL: strURL, andDelegate: delegate)
        
        /* Add request operation to Queue. */
        arrRequestList.add(objDownloadDetail)
        self.sendRequest()
    }
    
    // MARK: - Periodic Send Request
    fileprivate func sendRequest() {
        for tempDownloadDetail in arrRequestList {
            let objDownloadDetail = tempDownloadDetail as! DownloadDetail
            if objDownloadDetail.eDownloadStatus == DownloadStatus.none {
                objDownloadDetail.eDownloadStatus = DownloadStatus.started
                let imgDownloadService = ImageDownloadService.init(objDownloadDetail)
                print("Adding Request - \(objDownloadDetail.id)")
                requestQueue?.addOperation {
                    imgDownloadService.main()
                }
            }
        }
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

    //MARK: removeCompletedOperation()
    func updateOperationStatus(_ objDownloadDetail:DownloadDetail!) {
        for tempDownloadDetail in arrRequestList {
             let downloadDetail = tempDownloadDetail as! DownloadDetail
            if downloadDetail.id == objDownloadDetail.id {
                downloadDetail.eDownloadStatus = objDownloadDetail.eDownloadStatus
                print("Updating Status - \(String(describing: downloadDetail.eDownloadStatus))")
            }
        }
    }
    
    func refreshQueue() {
        if (arrRequestList.count > 0) {
            let eRequestList = arrRequestList.mutableCopy() as! NSMutableArray
            for tempDownloadDetail in eRequestList {
                let downloadDetail = tempDownloadDetail as! DownloadDetail
                if downloadDetail.eDownloadStatus == DownloadStatus.downloaded {
                    print("Deleting Completed Request - \(String(describing: downloadDetail.id)) with status: \(downloadDetail.eDownloadStatus)")
                    
                    var dictResults:[String:Any] = [:]
                    
                    dictResults["data"] = downloadDetail.dImageData
                    dictResults["url"] = downloadDetail.strDownloadLocation
                    
                    /* call success handler */
                    if downloadDetail.cDelegate != nil {
                        DispatchQueue.main.async {
                            downloadDetail.cDelegate?.didFinishImageDownloadWithStatus(true, andData:dictResults)
                        }
                    } else {
                        downloadDetail.successHandler([:])
                    }
                    arrRequestList.remove(tempDownloadDetail)
                } else if downloadDetail.eDownloadStatus == DownloadStatus.failed {
                    print("Deleting Completed Request - \(String(describing: downloadDetail.id)) with status: \(downloadDetail.eDownloadStatus)")
                    if downloadDetail.cDelegate != nil {
                        DispatchQueue.main.async {
                            downloadDetail.cDelegate?.didFinishImageDownloadWithStatus(false, andData: [:])
                        }
                    } else {
                        downloadDetail.failureHandler()
                    }
                    arrRequestList.remove(tempDownloadDetail)
                }
            }
        }
    }
    
    deinit {
        nRequestCount = 0
        stopTimer()
        unregisterNotifications()
    }
}
