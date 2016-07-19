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

struct MyArtist {
    let artistName:String
    let playCount:Int
    //can add other stuff later
}

func ==(a:MPMediaItem, b:MPMediaItem) -> Bool{
    if(a.artist == b.artist){
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
//        
//        let request = Alamofire.request(.GET,
//                                        "https://ws.audioscrobbler.com/2.0",
//                                        parameters: nil,
//                                        encoding: .URL,
//                                        headers: [:])
//        
//        request.responseJSON { data in
//            print(data)
//        }
//        
        beginCalls(myArtists!)
        ArtistsController.sharedInstance.makeCalls({ artist, message in
            if(message == nil){
                //call successful
                ArtistsController.sharedInstance.myArtists.append(artist!)
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
            if let artistName = artists[counter].artist {
                let myNewArtistObj = MyArtist(artistName: artists[counter].artist!, playCount: artists[counter].playCount)
                ArtistsController.sharedInstance.originalArtists.append(myNewArtistObj)
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
        cell.myImage = UIImageView(image: ArtistsController.sharedInstance.myArtists[indexPath.row].img)
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //??
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let artistView:ArtistViewController = ArtistViewController(nibName: "ArtistViewController", bundle: nil)
        artistView.modalPresentationStyle = .OverFullScreen
        self.presentViewController(artistView, animated: true, completion: nil)
    }
}
