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
    var bShouldLoad:Bool! = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configureCellWithData(_ objImageData:Image!)->Swift.Void {
        self.lblName?.numberOfLines = 2
        self.lblName?.text = objImageData.user.name
        self.backgroundColor = UIColor.yellow
    }
    
    func addProgressIndicator() {
        Utilities.sharedInstance.addProgressIndicator(self.contentView)
    }
    
    func removeProgressIndicator() {
        Utilities.sharedInstance.removeProgressIndicator()
    }
}
