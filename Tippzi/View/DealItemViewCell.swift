//
//  DealItemViewCell.swift
//  Tippzi
//
//  Created by Admin on 11/13/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class DealItemViewCell: UITableViewCell {

    @IBOutlet weak var barTitleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var day_durationLabel: UILabel!
    
    @IBOutlet weak var editDealBtn: UIButton!
    
    @IBOutlet weak var labImpressionsItem: UILabel!
    
    @IBOutlet weak var labEngagementsItem: UILabel!
    
    @IBOutlet weak var labClicksItem: UILabel!
    
    @IBOutlet weak var winkImageView: UIImageView!
    
    @IBOutlet weak var readImageView: UIImageView!
    
    @IBOutlet weak var walletImageView: UIImageView!
    
    @IBOutlet weak var btnDeleteDeal: UIButton!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "DashItemView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UITableViewCell
    }
}
