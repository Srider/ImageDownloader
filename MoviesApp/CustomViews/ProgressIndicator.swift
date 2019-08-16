//
//  ProgressIndicator.swift
//  MovieApp
//
//  Created by Srikar on 06/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import UIKit

class ProgressIndicator: UIView {

    var mActivityIndicatorView:UIActivityIndicatorView!
    
    func setUpView() {
        mActivityIndicatorView = UIActivityIndicatorView.init()
        mActivityIndicatorView.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(mActivityIndicatorView)
        self.setUpConstraints()
    }
    
    func constraints(_ format:String,  views withViews:NSDictionary)->(NSArray)
    {
        return NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: withViews as! [String : Any]) as (NSArray)
    }
    
    func constraintFor(_ view: UIView, attribute forAttribute:NSLayoutConstraint.Attribute, relation byRelation:NSLayoutConstraint.Relation, item toItem: UIView, attribute toAttribute:NSLayoutConstraint.Attribute, multiplier withMultiplier:CGFloat, constant andConstant:CGFloat)->(NSLayoutConstraint) {
        return
            NSLayoutConstraint.init(item: view, attribute: forAttribute, relatedBy: byRelation, toItem: toItem, attribute: toAttribute, multiplier: withMultiplier, constant: andConstant)
    }
    
    
    func setUpConstraints() {
    
        // 1. Create a dictionary of views
        self.addConstraint(self.constraintFor(mActivityIndicatorView, attribute: NSLayoutConstraint.Attribute.centerX, relation: NSLayoutConstraint.Relation.equal, item: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0))
        
        self.addConstraint(self.constraintFor(mActivityIndicatorView, attribute: NSLayoutConstraint.Attribute.centerY, relation: NSLayoutConstraint.Relation.equal, item: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0))
       
        
        self.addConstraint(self.constraintFor(mActivityIndicatorView, attribute: NSLayoutConstraint.Attribute.width, relation: NSLayoutConstraint.Relation.equal, item: self, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 50.0))
        
        self.addConstraint(self.constraintFor(mActivityIndicatorView, attribute: NSLayoutConstraint.Attribute.height, relation: NSLayoutConstraint.Relation.equal, item: self, attribute: NSLayoutConstraint.Attribute.height, multiplier: 0, constant: 50.0))

    }
    

    //Method for starting the animation
    func startAnimation() {
        //use startAnimating for starting the animation.
        mActivityIndicatorView.startAnimating()
    }
    
    //Method for starting the animation
    func isAnimating()->Bool {
        return mActivityIndicatorView.isAnimating
    }
    
    //Method for stopping the animation
     func stopAnimation()
    {
        //use stopAnimating for stopping the animation.
        mActivityIndicatorView.stopAnimating()
    }
    
}
