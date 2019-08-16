//
//  DefaultCellCollectionViewCell.swift
//  Countries
//
//  Created by Honeywell on 12/11/17.
//  Copyright © 2017 Honeywell. All rights reserved.
//

import UIKit

class MovieInfoCell: UICollectionViewCell {

    @IBOutlet var imgMovieImage:UIImageView?                  /* UILabel for displaying Country Parameter Name */
    @IBOutlet var lblMovieName:UILabel?                  /* UILabel for displaying Country Parameter Value */
    var bShouldLoad:Bool! = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
