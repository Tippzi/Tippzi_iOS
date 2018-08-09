    //
//  ClaimAlertViewController.swift
//  Tippzi
//
//  Created by Admin on 11/28/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class HuntResponsiblyViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playButton.setViewBorderStyle(cornerRadius: self.playButton.frame.height / 2, borderWidth: 2, borderColor: UIColor.white)
        self.playButton.backgroundColor = UIColor.clear
        self.playButton.setTitleColor(UIColor.white, for: UIControlState.normal)
//        self.playButton.setTitleColor(UIColor.black, for: UIControlState.highlighted)
    }
    
    @IBAction func playAction(_ sender: Any) {
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "TippziGoMapViewController")
        self.navigationController?.pushViewController(toViewController!, animated: true)
    }
}
