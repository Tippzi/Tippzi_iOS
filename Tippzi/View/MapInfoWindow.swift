//
//  MapInfoWindow.swift
//  Tippzi
//
//  Created by Admin on 11/26/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class MapInfoWindow: UILabel {

    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "MapInfoWindowView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UILabel
    }
}
