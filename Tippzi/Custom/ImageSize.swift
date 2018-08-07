//
//  ImageSize.swift
//  Tippzi
//
//  Created by Admin on 12/3/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

struct ImageSize {
    var width : CGFloat = 0
    var height : CGFloat = 0
    var winkImageView_width: CGFloat = 0
    var winkImageView_height: CGFloat = 0
    var readImageView_width:CGFloat = 0
    var readImageView_height:CGFloat = 0
    var walletImageView_width: CGFloat = 0
    var walletImageView_height: CGFloat = 0
    var check_width : CGFloat = 0
    var check_height : CGFloat = 0
    
    init(_ width: CGFloat, _ height : CGFloat, _ winkImageView_width : CGFloat, _ winkImageView_height : CGFloat, _ readImageView_width : CGFloat, _ readImageView_height : CGFloat, _ walletImageView_width : CGFloat, _ walletImageView_height : CGFloat, _ check_width : CGFloat, _ check_height : CGFloat) {
        self.width = width
        self.height = height
        self.winkImageView_width = winkImageView_width
        self.winkImageView_height = winkImageView_height
        self.readImageView_width = readImageView_width
        self.readImageView_height = readImageView_height
        self.walletImageView_width = walletImageView_width
        self.walletImageView_height = walletImageView_height
        self.check_width = check_width
        self.check_height = check_height
    }
}
