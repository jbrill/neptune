//
//  ViewController.swift
//  Tune In
//
//  Created by Jason Brill on 7/17/16.
//  Copyright © 2016 Jason Brill. All rights reserved.
//

import UIKit
import MediaPlayer
import Alamofire
import SwiftyJSON

class MyArtist : NSObject {
    override func isEqual(object: AnyObject?) -> Bool {
        if let rhs = object as? MyArtist {
            return self.myName == rhs.myName
        }
        return false
    }
    
    init (nameIn:String, countIn:Int){
        myName = nameIn
        playCount = countIn
    }
    
    var myName:String
    let playCount:Int
    //can add other stuff later
}



func ==(a:MPMediaItem, b:MPMediaItem) -> Bool{
    if let name = a.artist?.lowercaseString, let name2 = b.artist?.lowercaseString {
        return name == name2
    }
    return false
}

func ==(a:MyArtist, b:ArtistEntry) -> Bool{
    if(a.myName.lowercaseString == b.name.lowercaseString){
        return true
    }
    return false
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var artistTable: UITableView!
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributedString = titleLabel.attributedText as! NSMutableAttributedString
        attributedString.addAttribute(NSKernAttributeName, value: 8.8, range: NSMakeRange(0, attributedString.length))
        titleLabel.attributedText = attributedString
        
        artistTable.delegate = self
        artistTable.dataSource = self
        artistTable.registerNib(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Identifier")
        
        let myArtists = MPMediaQuery.artistsQuery().items
        
        beginCalls(myArtists!)
        ArtistsController.sharedInstance.sortArtists()
        
        ArtistsController.sharedInstance.makeCalls({ originalArtist, newArtist, message in
                if(newArtist == nil && message == nil){
                    self.artistTable.reloadData()
                } else if (newArtist != nil && message == nil){ //if we do have a new artist!!
                    let tempArtist = MyArtist(nameIn: newArtist!.name, countIn: 0)
                    if ArtistsController.sharedInstance.originalArtists.contains(tempArtist){
                        self.artistTable.reloadData()
                    } else if let index = ArtistsController.sharedInstance.myArtists.indexOf(newArtist!){ //check if new artist is already a new artist
                        ArtistsController.sharedInstance.myArtists[index].pushRec(originalArtist!)
                        
                    } else {
                        ArtistsController.sharedInstance.myArtists.append(newArtist!)
                    }
                    
                } else {
                    print(message!)
                    //ERROR. Make alert?
                }
        })
        
        
    }
    
    func beginCalls(artists:[MPMediaItem]){
        var counter:Int = 0

        while(counter != artists.count - 1){
//            print(artists[counter].artist)
//            print(counter)
//            print("MY COUNT: \(artists.count)")
            while(artists[counter] == artists[counter + 1]){
                if(counter == artists.count - 2){
                    break
                }
                counter += 1
            }//while we have same artist
            if let name = artists[counter].artist {
                let myNewArtistObj = MyArtist(nameIn: name, countIn: artists[counter].playCount)
                ArtistsController.sharedInstance.originalArtists.append(myNewArtistObj)
                ArtistsController.sharedInstance.totalPlays += artists[counter].playCount
            }
            
            counter += 1
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return myStrings.count;
        return ArtistsController.sharedInstance.myArtists.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "Identifier"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! TableViewCell
        
        cell.myTitle.text = ArtistsController.sharedInstance.myArtists[indexPath.row].name
        cell.myRecs.text = ("Based off \(ArtistsController.sharedInstance.myArtists[indexPath.row].recs.count) similar artists")
        
         Alamofire.request(.GET, NSURL(string: ArtistsController.sharedInstance.myArtists[indexPath.row].img)!).response { (request, response, data, error) in
            let myImg = UIImage(data: data!, scale:1)
            cell.myImage = UIImageView(image: myImg)
         }
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //??
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let artistView:ArtistViewController = ArtistViewController(nibName: "ArtistViewController", bundle: nil)
        
        //artistView.myRecs = ArtistsController.sharedInstance.myArtists[indexPath.row].recs.count
        //artistView.myTitle.text = ArtistsController.sharedInstance.myArtists[indexPath.row].name
        
        artistView.modalPresentationStyle = .OverFullScreen
        self.presentViewController(artistView, animated: true, completion: nil)
    }
}
