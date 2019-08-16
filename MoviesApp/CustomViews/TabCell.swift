//
//  TabCell.swift
//  MovieApp
//
//  Created by Srikar on 31/07/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import UIKit

class TabCell: UICollectionViewCell {

    @IBOutlet var imgTabImage:UIImageView?                  /* UILabel for displaying Country Parameter Name */
    @IBOutlet var lblTabName:UILabel?                  /* UILabel for displaying Country Parameter Value */
    @IBOutlet var viewHolder:UIView?  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
