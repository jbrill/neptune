//
//  ArtistViewController.swift
//  Tune In
//
//  Created by Jason Brill on 7/18/16.
//  Copyright © 2016 Jason Brill. All rights reserved.
//

import UIKit

class ArtistViewController: UIViewController {
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var myRecs: UILabel!
    @IBOutlet weak var myDesc: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myImage.layer.masksToBounds = false
        myImage.layer.cornerRadius = myImage.frame.height/2
        myImage.clipsToBounds = true
        
        //applyHoverShadow(myImage)
        let attributedString = myTitle.attributedText as! NSMutableAttributedString
        attributedString.addAttribute(NSKernAttributeName, value: 0.74, range: NSMakeRange(0, attributedString.length))
        myTitle.attributedText = attributedString
        
        let attributedString2 = myRecs.attributedText as! NSMutableAttributedString
        attributedString2.addAttribute(NSKernAttributeName, value: 0.34, range: NSMakeRange(0, attributedString2.length))
        myRecs.attributedText = attributedString2

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
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

    @IBAction func didExit(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
