//
//  TableViewCell.swift
//  Tune In
//
//  Created by Jason Brill on 7/18/16.
//  Copyright © 2016 Jason Brill. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var myRecs: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let attributedString = myTitle.attributedText as! NSMutableAttributedString
        attributedString.addAttribute(NSKernAttributeName, value: 6.4, range: NSMakeRange(0, attributedString.length))
        myTitle.attributedText = attributedString
        
        let attributedString2 = myRecs.attributedText as! NSMutableAttributedString
        attributedString2.addAttribute(NSKernAttributeName, value: 4, range: NSMakeRange(0, attributedString2.length))
        myRecs.attributedText = attributedString2
        
//        myImage.layer.borderWidth = 1
        myImage.layer.masksToBounds = false
//        myImage.layer.borderColor = UIColor.blackColor().CGColor
        myImage.layer.cornerRadius = myImage.frame.height/2
        myImage.clipsToBounds = true
        
        //applyHoverShadow(myImage)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    
//    func applyHoverShadow(view: UIView) {
//        let size = view.bounds.size
//        let width = size.width
//        let height = size.height
//        
//        let ovalRect = CGRect(x: 5, y: height + 5, width: width - 10, height: 15)
//        let path = UIBezierPath(roundedRect: ovalRect, cornerRadius: 10)
//        
//        let layer = view.layer
//        layer.shadowPath = path.CGPath
//        layer.shadowColor = UIColor.blackColor().CGColor
//        layer.shadowOpacity = 0.2
//        layer.shadowRadius = 5
//        layer.shadowOffset = CGSize(width: 2, height: 2)
//    }
}
