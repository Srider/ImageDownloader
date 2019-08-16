//
//  ImageCell.swift
//  MovieApp
//
//  Created by Srikar on 06/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet var imgMovieImage:UIImageView!

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//        print("Awake called in ImageCell")
//        
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
