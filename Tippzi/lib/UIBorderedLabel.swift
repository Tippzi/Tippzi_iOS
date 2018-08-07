//
//  UIBorderedLabel.swift
//  Tippzi
//
//  Created by Admin on 12/5/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class UIBorderedLabel: UILabel {

    var topInset: CGFloat = 0
    var rightInset: CGFloat = 10
    var bottomInset: CGFloat = 0
    var leftInset: CGFloat = 10

    override func drawText(in rect: CGRect) {
        
        var insets : UIEdgeInsets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        self.setNeedsLayout()
        return super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}
