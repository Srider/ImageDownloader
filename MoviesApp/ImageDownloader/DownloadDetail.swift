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
    case pending
    case downloading
    case downloaded
}

class DownloadDetail: NSObject {
    var id:UInt64!
    var strDownloadURL:String!
    var strDownloadLocation:URL?
    var dImageData:Data?
    var successHandler:([String:Any])->Void = {([String:Any]) -> Void in}
    var failureHandler:()->Void={}
    var eDownloadStatus:DownloadStatus!

    init(_ id: UInt64!, withURL strURL:String!, onSuccess successBlock:@escaping (_ demoData:[String:Any]) -> Void, onFailure failureBlock:@escaping () -> ()) {
        super.init()
        self.id = id
        self.strDownloadURL = strURL
        self.successHandler = successBlock
        self.failureHandler = failureBlock
        self.eDownloadStatus = DownloadStatus.none
    }

}
