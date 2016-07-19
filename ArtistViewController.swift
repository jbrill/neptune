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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myImage.layer.masksToBounds = false
        //        myImage.layer.borderColor = UIColor.blackColor().CGColor
        myImage.layer.cornerRadius = myImage.frame.height/2
        myImage.clipsToBounds = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

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
