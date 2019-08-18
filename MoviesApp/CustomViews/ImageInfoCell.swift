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
    var bShouldShowLoad:Bool!
    var objImageData:Image!
    var indicator:ProgressIndicator?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bShouldShowLoad = false
    }
    
    func configureCellWithData(_ objImageData:Image!)->Swift.Void {
        self.lblName?.numberOfLines = 2
        self.lblName?.text = objImageData.user.name
        self.backgroundColor = UIColor.yellow
        self.objImageData = objImageData
        
        if self.objImageData.dImageData != nil && self.objImageData.bImageFetchCompleted == true {
            self.removeProgressIndicator()
            let objImage:UIImage? = UIImage(data: self.objImageData.dImageData!)
            let image: UIImage!
            if objImage == nil {
               image = Utilities.sharedInstance.scaleUIImageToSize(UIImage(named: "no-image")!, toSize:(self.imgCellImage?.frame.size)!)
            } else {
               image = Utilities.sharedInstance.scaleUIImageToSize(objImage!, toSize:(self.imgCellImage?.frame.size)!)
            }
            self.imgCellImage?.image = image
        } else if self.objImageData.dImageData == nil && self.objImageData.bImageFetchCompleted == true {
            self.removeProgressIndicator()
            let image: UIImage! = Utilities.sharedInstance.scaleUIImageToSize(UIImage(named: "no-image")!, toSize:(self.imgCellImage?.frame.size)!)
            self.imgCellImage?.image = image
            
        } else if self.objImageData.dImageData == nil && self.objImageData.bImageFetchCompleted == false {
            let image: UIImage! = Utilities.sharedInstance.scaleUIImageToSize(UIImage(named: "no-image")!, toSize:(self.imgCellImage?.frame.size)!)
            self.imgCellImage?.image = image
            self.addProgressIndicator()
        }
        self.setNeedsDisplay()
    }
    
    func addProgressIndicator() {
        if bShouldShowLoad == false {
            bShouldShowLoad = true
            indicator =   ProgressIndicator.init()
            self.indicator!.translatesAutoresizingMaskIntoConstraints = false
            self.indicator!.backgroundColor = UIColor.darkGray
            self.indicator!.alpha = 0.6
            self.addSubview(self.indicator!)
            
            self.addConstraint(NSLayoutConstraint.init(item: indicator!, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint.init(item: indicator!, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint.init(item: indicator!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint.init(item: indicator!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0))
            
            self.bringSubviewToFront(self.indicator!)
            self.indicator!.setUpView()
            self.indicator!.startAnimation()
        }
    }
    
    func removeProgressIndicator() {
        if bShouldShowLoad == true {
            bShouldShowLoad = false
            self.indicator!.stopAnimation()
            self.indicator!.removeFromSuperview()
        }
    }
}
