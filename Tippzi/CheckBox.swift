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
    let checkedImage = UIImage(named: "ic_check")! as UIImage
    let uncheckedImage = UIImage(named: "ic_uncheck")! as UIImage
    
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
    
    func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }

}
