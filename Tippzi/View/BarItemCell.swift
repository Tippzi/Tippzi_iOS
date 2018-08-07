//
//  BarItemCell.swift
//  Tippzi
//
//  Created by Admin on 11/21/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import Koloda

class BarItemCell: UICollectionViewCell {
    
    @IBOutlet weak var dealTitleLabel: UILabel!
    @IBOutlet weak var dealDescriptionLabel: UILabel!
    @IBOutlet weak var barImageView: UIImageView!
    @IBOutlet weak var remainLabel: UILabel!
    @IBOutlet weak var barTitlelabel: UILabel!
    @IBOutlet weak var musicTypeLabel: UILabel!
    @IBOutlet weak var detailviewBtn: UIButton!
    @IBOutlet weak var kolodaView: KolodaView!
    
    @IBOutlet weak var remainView: UIView!
    @IBOutlet weak var barView: UIView!
}
