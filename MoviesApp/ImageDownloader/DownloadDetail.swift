//
//  ImageURL.swift
//  ImageDownloader
//
//  Created by Srikar on 17/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import UIKit

enum DownloadStatus {
    case none
    case started
    case downloading
    case downloaded
    case failed
}

class DownloadDetail: NSObject {
    var id:UInt64!
    var strDownloadURL:String!
    var strDownloadLocation:URL?
    var dImageData:Data?
    var successHandler:([String:Any])->Void = {([String:Any]) -> Void in}
    var failureHandler:()->Void={}
    var eDownloadStatus:DownloadStatus!
    var cDelegate:ImageDownloadDelegate!

    init(_ id: UInt64!, withURL strURL:String!, onSuccess successBlock:@escaping (_ demoData:[String:Any]) -> Void, onFailure failureBlock:@escaping () -> ()) {
        super.init()
        self.id = id
        self.strDownloadURL = strURL
        self.successHandler = successBlock
        self.failureHandler = failureBlock
        self.eDownloadStatus = DownloadStatus.none
    }
    
    init(_ id: UInt64!, withURL strURL:String!, andDelegate delegate:ImageDownloadDelegate!) {
        super.init()
        self.id = id
        self.strDownloadURL = strURL
        self.cDelegate = delegate
        self.eDownloadStatus = DownloadStatus.none
    }

}
