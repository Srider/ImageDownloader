//
//  DefaultCellCollectionViewCell.swift
//  Countries
//
//  Created by Honeywell on 12/11/17.
//  Copyright © 2017 Honeywell. All rights reserved.
//

import UIKit

class ImageInfoCell: UICollectionViewCell {

    @IBOutlet var imgCellImage:UIImageView?                  /* UILabel for displaying Country Parameter Name */
    @IBOutlet var lblName:UILabel?                  /* UILabel for displaying Country Parameter Value */
    var bShouldLoad:Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bShouldLoad = true
    }
    
    
    func configureCellWithData(_ objImageData:Image!)->Swift.Void {
        self.lblName?.numberOfLines = 2
        self.lblName?.text = objImageData.user.name
        self.backgroundColor = UIColor.yellow
        
        if bShouldLoad == true {
            self.addProgressIndicator()
            ImageDownloadManager.sharedDownloadManager.addDownloadRequest(objImageData.urls.raw, onSuccess: didCompleteDownloadingImage, onFailure: didFailToDownloadImage)
        }
    }
    
    func addProgressIndicator() {
        bShouldLoad = false
        Utilities.sharedInstance.addProgressIndicator(self.contentView)
    }
    
    func removeProgressIndicator() {
        bShouldLoad = true
        Utilities.sharedInstance.removeProgressIndicator()
    }
    
    func didCompleteDownloadingImage(_ dictData:[String:Any])->Void {
        self.removeProgressIndicator()

    }
    
    func didFailToDownloadImage()->Void {
        self.removeProgressIndicator()

    }
}
