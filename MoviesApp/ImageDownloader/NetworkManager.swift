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

    
    //Configure Request Queue and Start Timer
    func configureManager() -> Void {
        
        /* Register for notifications */
        registerNotifications()
        
        /* Make serial. */
        requestQueue?.maxConcurrentOperationCount = 1
        
        /* Start Timer */
//        startTimer()
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
                self.sendRequest()
            })
        }
    }
    
    //Stop Timer
    func stopTimer() {
        if timer != nil {
            timer.invalidate()
        }
    }

    public func addRequestToQueue( _ objDownloadDetail:DownloadDetail!) {
        
        /* Add request operation to Queue. */
        arrRequestList.add(objDownloadDetail!)
        self.sendRequest()
    }
    
    // MARK: - Periodic Send Request
    fileprivate func sendRequest() {
        if (arrRequestList.count > 0) {
            for tempDownloadDetail in arrRequestList {
                let objDownloadDetail = tempDownloadDetail as! DownloadDetail
                if objDownloadDetail.eDownloadStatus == DownloadStatus.none {
                    let imgDownloadService = ImageDownloadService.init(objDownloadDetail)
                    print("Adding Request - \(objDownloadDetail.id)")
                    requestQueue?.addOperation {
                        imgDownloadService.main()
                    }
                }
            }
        } 
    }

    //MARK: didUpdateSearchResults()
     @objc func didUpdateResultsWithData(_ notification:Notification)->Void {
        let dictResults = notification.object! as! NSMutableDictionary
        let objDownloadDetail = dictResults.object(forKey: "download_detail") as! DownloadDetail
        
        removeCompletedOperation(objDownloadDetail)
        
        /* call success handler */
        objDownloadDetail.successHandler([:])
    }
    
    //MARK: didFailToSendRequest()
    @objc func didEndRequestWithFailure(_ notification:Notification)->Void {
        
        let dictResults = notification.object! as! NSMutableDictionary
        let objDownloadDetail = dictResults.object(forKey: "download_detail") as! DownloadDetail
        removeCompletedOperation(objDownloadDetail)
        
        /* call success handler */
        objDownloadDetail.failureHandler()

    }

    //MARK: removeCompletedOperation()
    func removeCompletedOperation(_ objDownloadDetail:DownloadDetail!) {
        let eRequestList = arrRequestList.mutableCopy() as! NSMutableArray
        for tempDownloadDetail in eRequestList {
             let downloadDetail = tempDownloadDetail as! DownloadDetail
            if downloadDetail.id == objDownloadDetail.id {
                print("Deleting Completed Request - \(String(describing: objDownloadDetail.id))")
                arrRequestList.remove(objDownloadDetail!)
            }
        }
    }
    
    deinit {
        stopTimer()
        unregisterNotifications()
    }
}
