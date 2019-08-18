//
//  ImageDownloadDelegate.swift
//  MoviesApp
//
//  Created by Srikar on 18/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import Foundation

protocol ImageDownloadDelegate: class{
    func didFinishImageDownloadWithStatus(_ status:Bool, andData data:[String:Any])
}
