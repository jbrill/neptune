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
    var recs:Int
    var img:UIImage
    
    init(namein:String, recsin:Int, imgin:UIImage){
        name = namein
        recs = recsin
        img = imgin
    }
}
