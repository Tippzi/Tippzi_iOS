//
//  CustomerDealItemViewCell.swift
//  Tippzi
//
//  Created by Admin on 11/20/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class CustomerDealItemViewCell: UITableViewCell {
    
    
    @IBOutlet weak var labDealName: UILabel!
    
    @IBOutlet weak var labDealDescription: UILabel!
    
    @IBOutlet weak var labBarName: UILabel!
    
    @IBOutlet weak var labRemaining: UILabel!
    
    @IBOutlet weak var btnClaimDeal: UIButton!
    
    @IBOutlet weak var btnDeleteWallet: UIButton!
    
    @IBOutlet weak var btnDeleteDeal: UIButton!
    
    @IBOutlet weak var location_category: UIImageView!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "WalletItemView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UITableViewCell
    }
    
}
