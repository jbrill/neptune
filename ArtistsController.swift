//
//  ArtistsController.swift
//  Tune In
//
//  Created by Jason Brill on 7/18/16.
//  Copyright © 2016 Jason Brill. All rights reserved.
//

import UIKit
import Alamofire

func <(a:MyArtist, b:MyArtist) -> Bool{
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
    
    let artist1 = ArtistEntry(namein: "Dr. Dre", recsin: 12, imgin: UIImage(named: "drake")!)
    let artist2 = ArtistEntry(namein: "Rihanna", recsin: 8, imgin: UIImage(named: "drake")!)
    let artist3 = ArtistEntry(namein: "Red Hot Chili Peppers", recsin: 6, imgin: UIImage(named: "drake")!)
    let artist4 = ArtistEntry(namein: "Four Tet", recsin: 4, imgin: UIImage(named: "drake")!)
    let artist5 = ArtistEntry(namein: "Burial", recsin: 6, imgin: UIImage(named: "drake")!)
    
    var myArtists:[ArtistEntry]? {
        get {
            return [artist1, artist2, artist3, artist4, artist5]
        }
    }
    
    var originalArtists:[MyArtist] = []
    
    func sortArtists(){
        quicksort_swift(&originalArtists, start: 0, end: originalArtists.count)
        originalArtists = originalArtists.reverse()
    }
    
    func makeCalls(onCompletion: (MyArtist?, String?) -> Void){
        for artist in originalArtists{
            
            
            let myCall: String = "https://ws.audioscrobbler.com/2.0/"
            
            let request = Alamofire.request(.GET,
                                            myCall,
                                            parameters: ["method":"artist.getsimilar",
                                                         "artist":artist.artistName,
                                                         "api_key":myKey,
                                                         "format":"json"],
                                            encoding: .URLEncodedInURL,
                                            headers: [:])
            
                print("HERE FOR \(request)")
                self.executeRequest(request, requestCompletionFunction: {responseCode, json in
                    print(responseCode)
                    if (responseCode / 100 == 2) {
                        //do stuff
                        print(json["similarartists"])
                        onCompletion(artist, nil)
                        return
                    } else {
                        let errorMessage = json["errors"]["full_messages"][0].stringValue
                        
                        onCompletion(nil,errorMessage)
                        return
                    }
                })
        }
    }
}
