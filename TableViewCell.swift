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
        attributedString2.addAttribute(NSKernAttributeName, value: 4, range: NSMakeRange(0, attributedString.length))
        myRecs.attributedText = attributedString
        
        myImage.layer.borderWidth = 1
        myImage.layer.masksToBounds = false
        myImage.layer.borderColor = UIColor.blackColor().CGColor
        myImage.layer.cornerRadius = myImage.frame.height/2
        myImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
