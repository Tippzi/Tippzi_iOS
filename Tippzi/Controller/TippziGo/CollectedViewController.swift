    //
//  ClaimAlertViewController.swift
//  Tippzi
//
//  Created by Admin on 11/28/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import SwiftHTTP
import JSONJoy
import CoreLocation

class CollectedViewController: UIViewController {

    @IBOutlet weak var walletButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.walletButton.setViewBorderStyle(cornerRadius: self.walletButton.frame.height / 2, borderWidth: 2, borderColor: UIColor.white)
        self.walletButton.backgroundColor = UIColor.clear
        self.walletButton.titleLabel?.textColor = UIColor.white
        
        self.continueButton.setViewBorderStyle(cornerRadius: self.continueButton.frame.height / 2, borderWidth: 2, borderColor: UIColor.white)
        self.continueButton.backgroundColor = UIColor.white
        self.continueButton.titleLabel?.textColor = UIColor.black
    }
    
    @IBAction func walletAction(_ sender: Any) {
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "WalletViewController")
        self.navigationController?.pushViewController(toViewController!, animated: true)
    }
    
    @IBAction func continueAction(_ sender: Any) {
        let toViewController = self.storyboard?.instantiateViewController(withIdentifier: "TippziGoMapViewController")
        self.navigationController?.pushViewController(toViewController!, animated: true)
    }
}
