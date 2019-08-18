//
//  DefaultCellCollectionViewCell.swift
//  Countries
//
//  Created by Honeywell on 12/11/17.
//  Copyright © 2017 Honeywell. All rights reserved.
//

import UIKit

class ImageInfoCell: UICollectionViewCell, ImageDownloadDelegate {

    @IBOutlet var imgCellImage:UIImageView?                  /* UILabel for displaying Country Parameter Name */
    @IBOutlet var lblName:UILabel?                  /* UILabel for displaying Country Parameter Value */
    var bShouldLoad:Bool!
    var objImageData:Image!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bShouldLoad = true
    }
    
    
    func configureCellWithData(_ objImageData:Image!)->Swift.Void {
        self.lblName?.numberOfLines = 2
        self.lblName?.text = objImageData.user.name
        self.backgroundColor = UIColor.yellow
        self.objImageData = objImageData
        
        if bShouldLoad == true {
            self.addProgressIndicator()
            ImageDownloadManager.sharedDownloadManager.addDownloadRequest(objImageData.urls.raw, withDelegate:self)
        }
    }
    
    func addProgressIndicator() {
        bShouldLoad = false
        Utilities.sharedInstance.addProgressIndicator(self.contentView)
    }
    
    func removeProgressIndicator() {
//        bShouldLoad = true
        Utilities.sharedInstance.removeProgressIndicator()
    }
    
//    func didCompleteDownloadingImage(_ dictData:[String:Any])->Void {
//        print("Calling Success for \(self.objImageData.id)")
//        self.removeProgressIndicator()
//        self.setNeedsDisplay()
//    }
//
//    func didFailToDownloadImage()->Void {
//        print("Calling Failure for \(self.objImageData.id)")
//
//        self.removeProgressIndicator()
//        self.setNeedsDisplay()
//    }
    
    func didFinishImageDownloadWithStatus(_ status:Bool, andData data:[String:Any]) {
        print("Calling Success for \(self.objImageData.id)")
        DispatchQueue.main.async {
            self.removeProgressIndicator()
            let objImageData:Data? = data["data"] as? Data
            if objImageData != nil {
                self.objImageData.dImageData = objImageData
                self.imgCellImage?.image = UIImage(data: objImageData!)
            } else {
                self.imgCellImage?.image = UIImage(named: "no-image")
            }
            self.setNeedsDisplay()
        }
    }
}
