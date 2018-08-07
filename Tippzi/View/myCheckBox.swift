//
//  CheckBox.swift
//  Tippzi
//
//  Created by Admin on 1/19/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class myCheckBox: UIButton {

    // Images
    let checkedImage = UIImage(named: "ico_check")! as UIImage
    let uncheckedImage = UIImage(named: "ico_uncheck")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControlState.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControlState.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }

}
