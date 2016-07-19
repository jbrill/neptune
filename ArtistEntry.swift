//
//  ArtistEntry.swift
//  Tune In
//
//  Created by Jason Brill on 7/18/16.
//  Copyright © 2016 Jason Brill. All rights reserved.
//

import UIKit

class ArtistEntry: NSObject {
    var name:String
    var recs:[MyArtist]
    var img:String
    
    init(namein:String, recsin:MyArtist, imgin:String){
        name = namein
        recs = [recsin]
        img = imgin
    }
    
    func pushRec(recIn:MyArtist){
        recs.append(recIn)
    }
}
