//
//  DetailInfoWindow.swift
//  Tippzi
//
//  Created by Admin on 11/28/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class DetailInfoWindow: UIView {

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var deal_title: UILabel!
    
    @IBOutlet weak var deal_description: UILabel!
    
    @IBOutlet weak var remainLabel: UILabel!
   
    @IBOutlet weak var durationLabel: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }
    
}
