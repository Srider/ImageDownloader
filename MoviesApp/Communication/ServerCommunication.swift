//
//  ServerCommunication.swift
//  MovieApp
//
//  Created by Srikar on 30/07/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import UIKit
import Alamofire

class ServerCommunication: NSObject  {
    static let sharedInstance = ServerCommunication()
    var url:String?
    var objSessionManager:SessionManager? = SessionManager.default

    private override init() {
        
    }
    
    func sendRequest(_ url:String!, type requestType:String!, withResult result:@escaping(_ response:DataResponse<Any>?)->Swift.Void) {
        print(url!)
        send_request(url!, type:requestType, handler: result)
    }
    
    func send_request(_ url:String,  type requestType:String!, handler:@escaping(_ response:DataResponse<Any>?)->Void) {
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                return .success
            }
            .responseJSON { response in
                handler(response)
        }
    }
}
