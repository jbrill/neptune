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

func magicAlgo(artistIn:ArtistEntry) -> Double{
    var plays:Int = 0
    for rec in artistIn.recs{
        plays += rec.playCount
    }
    
    let myDec:Double = Double(plays) / Double(ArtistsController.sharedInstance.totalPlays)
    
    return myDec * Double(artistIn.recs.count)
}

func <(a:ArtistEntry, b:ArtistEntry) -> Bool {
    if(magicAlgo(a) < magicAlgo(b)){
        return true
    }
    return false
}

func >(a:ArtistEntry, b:ArtistEntry) -> Bool{
    if(magicAlgo(a) > magicAlgo(b)){
        return true
    }
    return false
}

func ==(a:ArtistEntry, b:ArtistEntry) -> Bool{
    if(magicAlgo(a) == magicAlgo(b)){
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

func quicksort_swift(inout a:[ArtistEntry], start:Int, end:Int) {
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
    
    var myArtists:[ArtistEntry] = []
    
    var originalArtists:[MyArtist] = []
    var totalPlays:Int = 0
    
    //var myTime:Int = 0
    
    func sortArtists(){
        quicksort_swift(&originalArtists, start: 0, end: originalArtists.count)
        originalArtists = originalArtists.reverse()
    }
    
    func sortArtistsNew(){
        quicksort_swift(&myArtists, start: 0, end: myArtists.count)
        myArtists = myArtists.reverse()
    }
    
//    @objc func update() {
//        myTime += 1
//    }
    
    func makeCalls(onCompletion: (MyArtist?, ArtistEntry?, String?) -> Void){
//        var timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        for artist in originalArtists{
            
//            
//            if(myTime >= 10){
//                break
//            }
            
            let parameters = ["method":"artist.getsimilar",
                              "artist":artist.myName,
                              "api_key":myKey,
                              "format":"json"]
            
            let request = self.createMutableAnonRequest(NSURL(string: "https://ws.audioscrobbler.com/2.0/"), method: "GET", parameters: parameters)
            
            self.executeRequest(request, requestCompletionFunction: {responseCode, json in
                if (responseCode / 100 == 2) {
                    //do stuff
                    var counter:Int = 0
                    for newArtist in json["similarartists"]["artist"]{
                        if(counter == 5){
                            break
                        }
                        
                        let name = newArtist.1["name"].stringValue
                        let imgURL = newArtist.1["image"][3]["#text"].stringValue
                        
                        let tempArtist:ArtistEntry = ArtistEntry(namein: name, recsin: artist, imgin: imgURL)
                        onCompletion(artist, tempArtist, nil)
                        self.sortArtistsNew()
                        counter += 1
                    }
                    
                    onCompletion(artist, nil,nil)
                } else {
                    let errorMessage = json["errors"]["full_messages"][0].stringValue
                    
                    onCompletion(artist, nil,errorMessage)
                    return
                }
            })
        }
        
        onCompletion(nil, nil,nil)
    }
    
    
}
