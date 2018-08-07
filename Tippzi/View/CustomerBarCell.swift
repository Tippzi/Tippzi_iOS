//
//  CustomerBarCell.swift
//  Tippzi
//
//  Created by Admin on 12/3/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import Koloda

class CustomerBarCell: UICollectionViewCell {
    
    @IBOutlet weak var barView: UIView!
    
    @IBOutlet weak var barImageView: SwiftyAvatar!
    @IBOutlet weak var dealImageView: UIImageView!
    
    @IBOutlet weak var barTitleLabel: UILabel!
    @IBOutlet weak var musicTypeLabel: UILabel!
    @IBOutlet weak var remainingView: UIView!
    @IBOutlet weak var remainLabel: UILabel!
    @IBOutlet weak var dealTitleLabel: UILabel!
    @IBOutlet weak var dealDescriptionLabel: UILabel!

    @IBOutlet weak var detailBtn: UIButton!
    
    @IBOutlet weak var kolodaView: KolodaView!
    
}
