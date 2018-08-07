//
//  CategoriesItemViewCell.swift
//  Tippzi
//
//  Created by Admin on 12/20/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class CategoriesItemViewCell: UITableViewCell {
    
    @IBOutlet weak var imgCategories: UIImageView!
    @IBOutlet weak var imgCategories_small: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var btnCategory: UIButton!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CategoriesItemView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UITableViewCell
    }
    
}


