//
//  CU_CardView.swift
//  Tippzi
//
//  Created by Admin on 11/28/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class CU_CardView: UIView {

    
    @IBOutlet weak var dealTitleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var durationText: UILabel!
    
    @IBOutlet weak var duration: UILabel!
    
    @IBOutlet weak var claimedLabel: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var claimBtn: UIButton!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CuCardView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }
}
