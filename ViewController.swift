//
//  ViewController.swift
//  Tune In
//
//  Created by Jason Brill on 7/17/16.
//  Copyright © 2016 Jason Brill. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var artistTable: UITableView!
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
//        titleLabel.textColor = UIColor.sand2()
        
        let attributedString = titleLabel.attributedText as! NSMutableAttributedString
        attributedString.addAttribute(NSKernAttributeName, value: 8.8, range: NSMakeRange(0, attributedString.length))
        titleLabel.attributedText = attributedString
        // Do any additional setup after loading the view.
        
        artistTable.delegate = self
        artistTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return myStrings.count;
        return ArtistsController.sharedInstance.myArtists.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "Identifier"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! TableViewCell
        
        cell.myTitle.text = ArtistsController.sharedInstance.myArtists[indexPath.row].name
        cell.myRecs.text = ("Based off \(ArtistsController.sharedInstance.myArtists[indexPath.row].recs) similar artists")
        cell.myImage = UIImageView(image: ArtistsController.sharedInstance.myArtists[indexPath.row].img)
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //??
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //present view!
    }
}
