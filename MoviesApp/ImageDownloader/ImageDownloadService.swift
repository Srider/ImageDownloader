//
//  CountriesService.swift
//  Countries
//
//  Created by Honeywell on 10/11/17.
//  Copyright © 2017 Honeywell. All rights reserved.
//

import UIKit

class ImageDownloadService:Operation{
    
    @objc var dictData:NSMutableDictionary!
    var mServiceURL: String!
    var mRequest:NSMutableURLRequest!
    var json:AnyObject!
    var objDownloadTask: URLSessionDownloadTask?
    var objDownloadDetail:DownloadDetail!
    
    init(_ objDownloadDetail:DownloadDetail!) {
        self.objDownloadDetail = objDownloadDetail
        self.mServiceURL = self.objDownloadDetail.strDownloadURL
        self.dictData = NSMutableDictionary.init()
    }
    
    //MARK: prepareRequest()->(NSMutableURLRequest)
    func prepareRequest()->(NSMutableURLRequest) {
        let tempRequest:NSMutableURLRequest! = NSMutableURLRequest.init()
        tempRequest.timeoutInterval = Constants.Timeout.kNetworkTimeout
        tempRequest.cachePolicy = .useProtocolCachePolicy
        tempRequest.httpMethod = Constants.RequestParam.kURLRequestType
        tempRequest.setValue(Constants.RequestParam.kURLRequestContentValue, forHTTPHeaderField: Constants.RequestParam.kURLRequestContentType)
        
        return tempRequest
    }
    
    //MARK: Response Caching
    @objc(URLSession:dataTask:willCacheResponse:completionHandler:) func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Void) {
        
        var newCachedResponse:CachedURLResponse? = proposedResponse
        let newUserInfo:NSDictionary! = NSDictionary.init(object: Date.init(), forKey: Constants.Caching.kURLCachedDate as NSCopying)
        
        if (proposedResponse.response.url?.scheme == Constants.Caching.kCachedURLType) {
            
            /* Cahcing if Request is ONLY of type "https:" */
            newCachedResponse = CachedURLResponse.init(response: proposedResponse.response, data: proposedResponse.data, userInfo: newUserInfo as? [AnyHashable : Any], storagePolicy: URLCache.StoragePolicy.allowedInMemoryOnly)
            
        } else {
            newCachedResponse = CachedURLResponse.init(response: proposedResponse.response, data: proposedResponse.data, userInfo: newUserInfo as? [AnyHashable : Any], storagePolicy: proposedResponse.storagePolicy)
        }
        completionHandler(newCachedResponse);
    }
    
    //MARK: main()
    override func main() {
        
        /* Call Preparerequest on BaseService */
        self.mRequest = self.prepareRequest()
        
        /* If Service is cancelled by any chance return */
        if self.isCancelled {
            return
        }
        
        /* Get request from URL String */
        self.mRequest.url = URL(string: self.mServiceURL)

        /* Fire Request using URLSession's dataTask API call */
        self.objDownloadTask = URLSession.shared.downloadTask(with: self.mRequest.url!, completionHandler: { (url, response, error) in
            print("*********************Completion Handler*********************")
            if error == nil {
                self.objDownloadDetail.eDownloadStatus = DownloadStatus.downloaded
                self.objDownloadDetail.strDownloadLocation = url
                self.dictData.setObject(self.objDownloadDetail, forKey: "download_detail" as NSCopying)
                
                /* Send Success Notification */
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name:Notification.Name(rawValue:Constants.Notifications.kNetworkOperationSuccess), object: self.dictData, userInfo: nil)
                }
            } else {
                /* Send Failure Notification */
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name:Notification.Name(rawValue:Constants.Notifications.kNetworkOperationFailure), object: self.dictData, userInfo: nil)
                }
            }
            print("URL - \(String(describing: url?.absoluteString))")
            print("URL - \(String(describing: url?.absoluteURL))")

            print("Response - \(String(describing: response))")
            print("Error - \(String(describing: error))")
        })
        
        /*Resume Task */
        self.objDownloadTask?.resume()
    }
}
