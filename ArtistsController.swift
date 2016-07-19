//
//  ArtistsController.swift
//  Tune In
//
//  Created by Jason Brill on 7/18/16.
//  Copyright © 2016 Jason Brill. All rights reserved.
//

import UIKit
import Alamofire


func <(a:MyArtist, b:MyArtist) -> Bool {
    if(a.playCount < b.playCount){
        return true
    }
    return false
}

func >(a:MyArtist, b:MyArtist) -> Bool{
    if(a.playCount > b.playCount){
        return true
    }
    return false
}

func ==(a:MyArtist, b:MyArtist) -> Bool{
    if(a.playCount == b.playCount){
        return true
    }
    return false
}

func quicksort_swift(inout a:[MyArtist], start:Int, end:Int) {
    if (end - start < 2){
        return
    }
    let p = a[start + (end - start)/2]
    var l = start
    var r = end - 1
    while (l <= r){
        if (a[l] < p){
            l += 1
            continue
        }
        if (a[r] > p){
            r -= 1
            continue
        }
        let t = a[l]
        a[l] = a[r]
        a[r] = t
        l += 1
        r -= 1
    }
    quicksort_swift(&a, start: start, end: r + 1)
    quicksort_swift(&a, start: r + 1, end: end)
}

class ArtistsController : WebService {
    static var sharedInstance:ArtistsController = ArtistsController()
    let myKey:String = "a658bb1ac88d31aaacb4038f7589f694"
    
//    let artist1 = ArtistEntry(namein: "Dr. Dre", recsin: "Dr Dre", imgin: UIImage(named: "drake")!)
//    let artist2 = ArtistEntry(namein: "Rihanna", recsin: "Dr Dre", imgin: UIImage(named: "drake")!)
//    let artist3 = ArtistEntry(namein: "Red Hot Chili Peppers", recsin: "Dr Dre", imgin: UIImage(named: "drake")!)
//    let artist4 = ArtistEntry(namein: "Four Tet", recsin: "Dr Dre", imgin: UIImage(named: "drake")!)
//    let artist5 = ArtistEntry(namein: "Burial", recsin: "Dr Dre", imgin: UIImage(named: "drake")!)
    
    var myArtists:[ArtistEntry] = []
    
    var originalArtists:[MyArtist] = []
    
    func sortArtists(){
        quicksort_swift(&originalArtists, start: 0, end: originalArtists.count)
        originalArtists = originalArtists.reverse()
    }
    
    func makeCalls(onCompletion: (ArtistEntry?, String?) -> Void){
        //for artist in originalArtists{
        let artist = originalArtists[0]
        
        let parameters = ["method":"artist.getsimilar",
         "artist":artist.artistName,
         "api_key":myKey,
         "format":"json"]
 
        let request = self.createMutableAnonRequest(NSURL(string: "https://ws.audioscrobbler.com/2.0/"), method: "GET", parameters: parameters)
        
            self.executeRequest(request, requestCompletionFunction: {responseCode, json in
                print("MY RESP CODE \(responseCode)")
                if (responseCode / 100 == 2) {
                    //do stuff
                    var counter:Int = 0
                    for newArtist in json["similarartists"]["artist"]{
                        if(counter == 5){
                            break
                        }
                        
                        let name = newArtist.1["name"].stringValue
                        let imgURL = newArtist.1["image"][3]["#text"].stringValue
                        
                        /*Alamofire.request(.GET, NSURL(string: imgURL.stringValue)!).response { (request, response, data, error) in
                            if let img = UIImage(data: data!, scale:1) {
                                
                            }
                        }*/
                        let tempArtist:ArtistEntry = ArtistEntry(namein: name, recsin: artist, imgin: imgURL)
                        onCompletion(tempArtist, nil)
                        
                        counter += 1
                    }
                    
                    print("here")
                    return
                } else {
                    let errorMessage = json["errors"]["full_messages"][0].stringValue
                    
                    onCompletion(nil,errorMessage)
                    return
                }
            })
        //}
    }
}
