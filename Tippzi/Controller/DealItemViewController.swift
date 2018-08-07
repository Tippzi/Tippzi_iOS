//
//  DaelItemViewController.swift
//  Tippzi
//
//  Created by Admin on 11/13/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class DealItemViewController: UIViewController {

    
    @IBOutlet weak var dealitemview: UIView!
    var onItemHeight : CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        onItemHeight = self.dealitemview.bounds.size.height
        Common.onItemHeight = onItemHeight!
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
